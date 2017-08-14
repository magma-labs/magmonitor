const initialState = {
  user: {},
  current_org: '',
  group_id: 0
};

export default function groupsManagerReducer(state = initialState, action) {
  const { type } = action;
  switch (type) {
    case 'UPDATE_USER':
      const user = action.user;
      return {
        ...state,
        user
      };
    case 'SET_CURRENT_ORG':
      const current_org= action.current_org;
      return {
        ...state,
        current_org
      };
    default:
      return state;
  }
}
