{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
, lima
, makeWrapper
}:

buildGoModule rec {
  pname = "colima";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "abiosoft";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-+P4kxiib1xkS4iGC2HrYAt0YMyXyEYPqoo1BkDs7jp8=";
  };

  nativeBuildInputs = [ installShellFiles makeWrapper ];

  vendorSha256 = "sha256-Z4+qwoX04VnLsUIYRfOowFLgcaA9w8oGRl77jzFigIc=";

  postInstall = ''
    wrapProgram $out/bin/colima \
      --prefix PATH : ${lib.makeBinPath [ lima ]}

    installShellCompletion --cmd colima \
      --bash <($out/bin/colima completion bash) \
      --fish <($out/bin/colima completion fish) \
      --zsh <($out/bin/colima completion zsh)
  '';

  meta = with lib; {
    description = "Container runtimes on MacOS with minimal setup";
    homepage = "https://github.com/abiosoft/colima";
    license = licenses.mit;
    maintainers = with maintainers; [ aaschmid ];
  };
}
