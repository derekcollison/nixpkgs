{ lib, stdenv, fetchFromGitHub, zlib }:

stdenv.mkDerivation rec {
  pname = "minimap2";
  version = "2.23";

  src = fetchFromGitHub {
    repo = pname;
    owner = "lh3";
    rev = "v${version}";
    sha256 = "sha256-oNVpSINcXO2eKzOCr/Fl8tSMguRxzmlDNu7hLZeopoQ=";
  };

  buildInputs = [ zlib ];

  installPhase = ''
    mkdir -p $out/bin
    cp minimap2 $out/bin
    mkdir -p $out/share/man/man1
    cp minimap2.1 $out/share/man/man1
  '';

  meta = with lib; {
    description = "A versatile pairwise aligner for genomic and spliced nucleotide sequences";
    homepage = "https://lh3.github.io/minimap2";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ maintainers.arcadio ];
  };
}
