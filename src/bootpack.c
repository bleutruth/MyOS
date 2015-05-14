
void io_hlt(void);

void MyOSMain(void)
{

fin:
	io_hlt(); /* ‚±‚ê‚Åmyosfunc.nas‚Ì_io_hlt‚ªÀs‚³‚ê‚Ü‚· */
	goto fin;

}
