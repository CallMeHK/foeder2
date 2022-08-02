import * as React from 'react'
import {  ApolloProvider } from '@apollo/client';
import { client } from '../shared/apollo-client'
import { UserTable } from './src/UserTable'

const App = () => {
    return <ApolloProvider client={client}>
        <UserTable />
    </ApolloProvider>
}

export {
    App
}
