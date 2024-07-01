// ignore_for_file: constant_identifier_names
// https://www.wswork.com.br
//--dart-define="API_BASE_URL=https://www.wswork.com.br"

const API_BASE_URL = String.fromEnvironment('API_BASE_URL', defaultValue: '');

const GET_GARS_API = '$API_BASE_URL/cars.json';
const POST_LEADS_API = '$API_BASE_URL/cars/leads';
