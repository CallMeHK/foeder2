import * as React from 'react'
import { EditUserModal } from './EditUserModal'
import { useGetAllUsersQuery, User } from '../../graphql'

const UserTable = () => {
    const [selectedUser, setSelectedUser] = React.useState<User | null>(null)
    const {data, loading} = useGetAllUsersQuery()

    if(loading) return <div>loading...</div>

    const users = data?.users || []
    const sortedUsers = [...users].sort((a, b) => parseInt(a.id) > parseInt(b.id) ? 1 : -1)

    return <div>
        <table className="table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Email</th>
              <th>Permissions</th>
              <th>Confirmation</th>
              <th>User updated</th>
              <th>Permissions updated</th>
              <th>Created</th>
            </tr>
          </thead>
          <tbody>
            {sortedUsers.map((user) => (
              <tr key={user.id} onClick={ () => setSelectedUser(user) } style={{ cursor: 'pointer' }}>
                  <td>{user.id}</td>
                  <td>{user.email}</td>
                  <td>{user.permissions.permittedActions.join(', ') || "No permissions"}</td>
                  <td>{user.confirmedAt || "Not confirmed"}</td>
                  <td>{user.updatedAt}</td>
                  <td>{user.permissions.updatedAt}</td>
                  <td>{user.insertedAt}</td>
                </tr>
              ))}
          </tbody>
        </table>
      {selectedUser !== null && <EditUserModal user={selectedUser} userPermissions={data.userPermissions} onClose={() => {setSelectedUser(null)}}/>}
    </div>

}

export {
    UserTable
}
