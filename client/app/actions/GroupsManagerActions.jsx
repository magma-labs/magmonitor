/* eslint-disable import/prefer-default-export */
export function updateUser(user) {
  return {
    type: 'UPDATE_USER',
    user
  };
}

export function setCurrentOrg(current_org) {
  return {
    type: 'SET_CURRENT_ORG',
    current_org
  };
}
