import React from 'react'
import './Container.css'

type ContainerProps = {
	style?: React.CSSProperties
	children: React.ReactNode
}
export const Container: React.FC<ContainerProps> = ({ children, style = {} }) => (
	<div className='shared-container' style={style}>{children}</div>
)

export const InnerContainer = ({ children, maxWidth = '800px', width = '100%' }) => (
	<div className='shared-inner-container' style={{maxWidth, width}}>{children}</div>
)
