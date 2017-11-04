// vim: set expandtab shiftwidth=4 tabstop=4:

#include <mathlink.h>
#include <Fermat.h>
#include <iostream>
using namespace std;

Fermat *fermat = NULL;

void FermatInit(const char *path) {
    fermat = new Fermat(path);
}

void FermatEval(const char *s) {
    string out;

    if (!fermat) {
        cerr << "not initialized";
        return;
    }

    out = (*fermat)(s);

    if (!MLPutString(stdlink,out.c_str())) {
        cout << "MLPutString - error." << endl;
    }
}

void FermatClose() {
    if (!fermat) {
        cerr << "not initialized";
        return;
    }
    
    delete fermat;
    fermat = NULL;
}

int main(int argc, char **argv) {
    return MLMain(argc,argv);
}


