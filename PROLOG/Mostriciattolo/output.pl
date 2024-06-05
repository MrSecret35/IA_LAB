
%--------------------------------------------------------
%-------------------------Output-------------------------
%--------------------------------------------------------

scriviCammino1(S,[Az|ListaAzioni],Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n"),

    trasformaMostro(Az,S,SNuovo,Ghiaccio,S,Gemme),
    trasformaGhiaccio(Az,Ghiaccio,GhiaccioN, Ghiaccio,Gemme,S),
    trasformaGhiaccio(Az,Gemme,GemmeN, Ghiaccio,Gemme,S),

    scriviCammino1(SNuovo,ListaAzioni,GhiaccioN,GhiaccioFinale,GemmeN,GemmeFinali).

scriviCammino1(S,[],Ghiaccio,Ghiaccio,Gemme,Gemme):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n").

scriviCammino2(S,[Az|ListaAzioni],Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n"),

    trasformaMostroConMartello(Az,S,SNuovo,Ghiaccio,S,GhiaccioNuovoDopoMostro,Gemme),
    trasformaGhiaccio(Az,GhiaccioNuovoDopoMostro,GhiaccioN, Ghiaccio,Gemme,S),
    trasformaGhiaccio(Az,Gemme,GemmeN, Ghiaccio,Gemme,S),

    scriviCammino2(SNuovo,ListaAzioni,GhiaccioN,GhiaccioFinale,GemmeN,GemmeFinali).

scriviCammino2(S,[],Ghiaccio,Ghiaccio,Gemme,Gemme):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n").