{ lib
, buildPythonPackage
, fetchFromGitHub
, graphviz
, appdirs
, ifaddr
, pythonOlder
, lxml
, mock
, nix-update-script
, pytestCheckHook
, requests
, requests-mock
, xmltodict
}:

buildPythonPackage rec {
  pname = "soco";
  version = "0.30.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "SoCo";
    repo = "SoCo";
    rev = "refs/tags/v${version}";
    hash = "sha256-xoHXUcHmzEDmE17r0+vI56UBAPQEhpglBkWtwE9b2Nw=";
  };

  propagatedBuildInputs = [
    appdirs
    ifaddr
    lxml
    requests
    xmltodict
  ];

  nativeCheckInputs = [
    pytestCheckHook
    graphviz
    mock
    requests-mock
  ];

  pythonImportsCheck = [
    "soco"
  ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "CLI and library to control Sonos speakers";
    homepage = "http://python-soco.com/";
    changelog = "https://github.com/SoCo/SoCo/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ lovesegfault ];
  };
}
