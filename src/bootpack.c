
void io_hlt(void);

void MyOSMain(void)
{

fin:
	io_hlt(); /* これでmyosfunc.nasの_io_hltが実行されます */
	goto fin;

}
