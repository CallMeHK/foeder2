import * as React from 'react'
import { useForm, Resolver } from "react-hook-form";
import './EditUserModal.css'
import { User, useUpdateUserInfoMutation } from '../../graphql'
import { Modal } from '../../shared/components/Modal'

type FormValues = {
  email: string,
  password?: string,
  confirmedAt?: string,
  [permission: string]: string
};

type Props = {
    user: User | null,
    userPermissions: string[],
    onClose: () => void
}

const validation = {
    email: {
        required: "Email is required", 
        pattern: {
            value: /^\S+@\S+\.\S+$/, 
            message: "This doesnt look like an email"
        }
    }
}
const EditUserModal: React.FC<Props> = ({ user, userPermissions, onClose }) => {
    const [success, setSuccess] = React.useState<boolean>(false)
    const [shouldResetPassword, setShouldResetPassword] = React.useState<boolean>(false)
    const [updateUser, {loading, error}] = useUpdateUserInfoMutation()
    const { register, handleSubmit, watch, formState: { errors }, setValue } = useForm<FormValues>();
    const onSubmit = handleSubmit(data => {
        updateUser({
            variables:{
                userId: user.id,
                email: data.email,
                ...(data.confirmedAt && {confirmedAt: 'datetime'}),
                ...(data.password && {password: data.password})
            }
        }).then(() => setSuccess(true))
        .then(() => setTimeout(onClose, 500))
    })
    console.log("watch", watch())

    const hasPermission = (permission: string) => user?.permissions?.permittedActions?.includes(permission) || false

    return <Modal isShowing={true} onClose={onClose} title="Edit User" maxWidth='1200px'>
        <form className='edit-user-form' onSubmit={onSubmit}>
            <label htmlFor="update_email">Email</label>
            <input 
                id="update_email" 
                name="email" 
                type="email" 
                defaultValue={user.email} 
                {...register("email", validation.email)} 
            />
            {errors?.email && <span>{errors.email.message}</span>}

            <div className='reset-password-tray'>
                <div style={{ paddingRight: '24px' }}>
                    <label htmlFor="reset_password">Reset Password</label>
                    <input 
                        id="reset_password" 
                        name="reset_password" 
                        type="checkbox" 
                        checked={shouldResetPassword} 
                        onChange={() => {setValue('password', ''); setShouldResetPassword(v => !v)}} 
                    />
                </div>
                {shouldResetPassword && <div>
                    <label htmlFor="new_password">New Password</label>
                    <input id="new_password" name="new_password" style={{ minWidth: '300px' }} {...register("password")}/>
                </div>}
            </div>


            <label htmlFor="set_email_confirmation">Email Confirmed</label>
            <input 
                id="set_email_confirmation" 
                name="email_confirmation" 
                type="checkbox" 
                defaultChecked={!!user?.confirmedAt} 
                {...register("confirmedAt")}
            />

            <label>Permissions</label>
            <div>
                {userPermissions.map((permission, i) => <div key={permission}>
                    <input id={permission} type='checkbox' defaultChecked={hasPermission(permission)} {...register(permission)} />
                    <span>{" "}{permission}</span>
                </div>)}
            </div>

            {!error && !loading && !success && <div style={{height: "12px", width: "100%", display: "flex", flexDirection: "row-reverse"}}></div>}
            {error && <div style={{color: 'red', height: "12px", width: "100%", display: "flex", flexDirection: "row-reverse"}}>Failed to submit form</div>}
            {loading && <div style={{color: 'blue', height: "12px", width: "100%", display: "flex", flexDirection: "row-reverse"}}>Submitting form.....</div>}
            {success && <div style={{color: 'blue', height: "12px", width: "100%", display: "flex", flexDirection: "row-reverse"}}>Successfully updated user</div>}

            <div className='submit-button-tray'>
                <button className='cancel-button' disabled={loading} onClick={onClose}>Cancel</button>
                <button disabled={loading} type='submit'>Submit</button>
            </div>
        </form>
    </Modal>
}

export {
    EditUserModal
}
