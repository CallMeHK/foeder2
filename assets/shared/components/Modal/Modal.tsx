import * as React from 'react'
import './Modal.css'

type Props = {
	isShowing: boolean,
	onClose: () => void
	children: React.ReactNode, 
	title: string,
	maxWidth?: string
}

const Modal: React.FC<Props> = ({ isShowing = true, onClose, children, title, maxWidth }) => {
	return <div id={`${title}-modal-anchor`}>
		{isShowing && (
		<div className="modal">
			<div className="modal-content" style={maxWidth && {maxWidth}}>
				<div className="modal-topbar">
					<span className="modal-title">{title}</span>
					<span className="close" onClick={onClose}>&times;</span>
				</div>
				<div className="modal-body">{children}</div>
			</div>
		</div>
		)}
	</div>
}

export { Modal }
