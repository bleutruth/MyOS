
void io_hlt(void);

void MyOSMain(void)
{

fin:
	io_hlt(); /* �����myosfunc.nas��_io_hlt�����s����܂� */
	goto fin;

}
