import { gql } from '@apollo/client';
import * as Apollo from '@apollo/client';
export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
const defaultOptions = {} as const;
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  NaiveDateTime: any;
};

export type Permissions = {
  __typename?: 'Permissions';
  id?: Maybe<Scalars['ID']>;
  permittedActions?: Maybe<Array<Maybe<Scalars['String']>>>;
  updatedAt?: Maybe<Scalars['NaiveDateTime']>;
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  /** Update user info */
  updateUserInfo?: Maybe<User>;
  /** Update user permissions */
  updateUserPermissions?: Maybe<Permissions>;
};


export type RootMutationTypeUpdateUserInfoArgs = {
  confirmedAt?: InputMaybe<Scalars['String']>;
  email?: InputMaybe<Scalars['String']>;
  password?: InputMaybe<Scalars['String']>;
  userId?: InputMaybe<Scalars['ID']>;
};


export type RootMutationTypeUpdateUserPermissionsArgs = {
  canAdminUsers?: InputMaybe<Scalars['Boolean']>;
  isSuperAdmin?: InputMaybe<Scalars['Boolean']>;
  userId: Scalars['ID'];
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  userPermissions?: Maybe<Array<Maybe<Scalars['String']>>>;
  /** Get all users */
  users?: Maybe<Array<Maybe<User>>>;
};

export type User = {
  __typename?: 'User';
  confirmedAt?: Maybe<Scalars['String']>;
  email?: Maybe<Scalars['String']>;
  id?: Maybe<Scalars['ID']>;
  insertedAt?: Maybe<Scalars['String']>;
  permissions?: Maybe<Permissions>;
  updatedAt?: Maybe<Scalars['String']>;
};

export type GetAllUsersQueryVariables = Exact<{ [key: string]: never; }>;


export type GetAllUsersQuery = { __typename?: 'RootQueryType', userPermissions?: Array<string | null> | null, users?: Array<{ __typename?: 'User', id?: string | null, email?: string | null, confirmedAt?: string | null, updatedAt?: string | null, insertedAt?: string | null, permissions?: { __typename?: 'Permissions', id?: string | null, permittedActions?: Array<string | null> | null, updatedAt?: any | null } | null } | null> | null };

export type UpdateUserInfoMutationVariables = Exact<{
  userId: Scalars['ID'];
  email?: InputMaybe<Scalars['String']>;
  confirmedAt?: InputMaybe<Scalars['String']>;
  password?: InputMaybe<Scalars['String']>;
}>;


export type UpdateUserInfoMutation = { __typename?: 'RootMutationType', updateUserInfo?: { __typename?: 'User', id?: string | null, email?: string | null, confirmedAt?: string | null, updatedAt?: string | null, permissions?: { __typename?: 'Permissions', id?: string | null, permittedActions?: Array<string | null> | null, updatedAt?: any | null } | null } | null };


export const GetAllUsersDocument = gql`
    query GetAllUsers {
  userPermissions
  users {
    id
    email
    confirmedAt
    updatedAt
    insertedAt
    permissions {
      id
      permittedActions
      updatedAt
    }
  }
}
    `;

/**
 * __useGetAllUsersQuery__
 *
 * To run a query within a React component, call `useGetAllUsersQuery` and pass it any options that fit your needs.
 * When your component renders, `useGetAllUsersQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useGetAllUsersQuery({
 *   variables: {
 *   },
 * });
 */
export function useGetAllUsersQuery(baseOptions?: Apollo.QueryHookOptions<GetAllUsersQuery, GetAllUsersQueryVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<GetAllUsersQuery, GetAllUsersQueryVariables>(GetAllUsersDocument, options);
      }
export function useGetAllUsersLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<GetAllUsersQuery, GetAllUsersQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<GetAllUsersQuery, GetAllUsersQueryVariables>(GetAllUsersDocument, options);
        }
export type GetAllUsersQueryHookResult = ReturnType<typeof useGetAllUsersQuery>;
export type GetAllUsersLazyQueryHookResult = ReturnType<typeof useGetAllUsersLazyQuery>;
export type GetAllUsersQueryResult = Apollo.QueryResult<GetAllUsersQuery, GetAllUsersQueryVariables>;
export const UpdateUserInfoDocument = gql`
    mutation UpdateUserInfo($userId: ID!, $email: String, $confirmedAt: String, $password: String) {
  updateUserInfo(
    userId: $userId
    email: $email
    confirmedAt: $confirmedAt
    password: $password
  ) {
    id
    email
    confirmedAt
    updatedAt
    permissions {
      id
      permittedActions
      updatedAt
    }
  }
}
    `;
export type UpdateUserInfoMutationFn = Apollo.MutationFunction<UpdateUserInfoMutation, UpdateUserInfoMutationVariables>;

/**
 * __useUpdateUserInfoMutation__
 *
 * To run a mutation, you first call `useUpdateUserInfoMutation` within a React component and pass it any options that fit your needs.
 * When your component renders, `useUpdateUserInfoMutation` returns a tuple that includes:
 * - A mutate function that you can call at any time to execute the mutation
 * - An object with fields that represent the current status of the mutation's execution
 *
 * @param baseOptions options that will be passed into the mutation, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options-2;
 *
 * @example
 * const [updateUserInfoMutation, { data, loading, error }] = useUpdateUserInfoMutation({
 *   variables: {
 *      userId: // value for 'userId'
 *      email: // value for 'email'
 *      confirmedAt: // value for 'confirmedAt'
 *      password: // value for 'password'
 *   },
 * });
 */
export function useUpdateUserInfoMutation(baseOptions?: Apollo.MutationHookOptions<UpdateUserInfoMutation, UpdateUserInfoMutationVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useMutation<UpdateUserInfoMutation, UpdateUserInfoMutationVariables>(UpdateUserInfoDocument, options);
      }
export type UpdateUserInfoMutationHookResult = ReturnType<typeof useUpdateUserInfoMutation>;
export type UpdateUserInfoMutationResult = Apollo.MutationResult<UpdateUserInfoMutation>;
export type UpdateUserInfoMutationOptions = Apollo.BaseMutationOptions<UpdateUserInfoMutation, UpdateUserInfoMutationVariables>;