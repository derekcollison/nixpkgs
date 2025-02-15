{ lib
, buildPythonPackage
, fetchPypi
, pyjwt
, pytestCheckHook
, python-dateutil
, requests
, responses
, tox
}:

buildPythonPackage rec {
  pname = "ibm-cloud-sdk-core";
  version = "3.13.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "9c615b3a6e9d9dc1c69d8f38742b156e12408521fa180a66558bbb7b850bbbc2";
  };

  propagatedBuildInputs = [
    pyjwt
    python-dateutil
    requests
  ];

  checkInputs = [
    pytestCheckHook
    responses
    tox
  ];

  disabledTests = [
    # Various tests try to access credential files which are not included with the source distribution
    "test_configure_service"
    "test_cp4d_authenticator"
    "test_cwd"
    "test_files_dict"
    "test_files_duplicate_parts"
    "test_files_list"
    "test_get_authenticator"
    "test_gzip_compression_external"
    "test_iam"
    "test_read_external_sources_2"
    "test_retry_config_external"
    # assertion error due to requests brotli support
    "test_http_client"
  ];

  disabledTestPaths = [
    "test/test_container_token_manager.py"
  ];

  meta = with lib; {
    description = "Client library for the IBM Cloud services";
    homepage = "https://github.com/IBM/python-sdk-core";
    license = licenses.asl20;
    maintainers = with maintainers; [ globin lheckemann ];
  };
}
