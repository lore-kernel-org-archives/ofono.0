Content-Type: multipart/mixed; boundary="===============5086757873089267273=="
MIME-Version: 1.0
From: Rohit Agrawal <agrawal.rohit1@gmail.com>
Subject: Print Backtrace on crash in Ofono
Date: Fri, 08 Dec 2017 14:00:47 +0530
Message-ID: <CAOLU1cSHTsdW+hWuuhQAAGXE_O_z+GQe77AG-oErtQFeRPXyyw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5086757873089267273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am trying to run Ofono on a ARM based AP processor. The backtrace
function which is present in Ofono is not working on that Processor though
I have done following:

Enabled -- > enable-debug option
Enabled -funwind_tables option in CC_FLAGS within enable-debug option
itself (configure.ac)
Provided -rdynamic option in LD_FLAGS within enable-debug option itseld (
configure.ac)

src/log.c
static void print_backtrace(unsigned int offset)
{
written =3D write(outfd[1], addr, len); -->This line is failing all the tim=
e.
}

I modified the print_backtrace() to below:

static void print_backtrace(unsigned int offset)
{
    void *frames[99];
    size_t n_ptrs;
    //unsigned int i;
    //int outfd[2], infd[2];
    int pathlen;
    //pid_t pid;

    if (program_exec =3D=3D NULL)
            return;

    pathlen =3D strlen(program_path);
    ofono_error("++++++++ backtrace +++++++++++++++++++++");

    n_ptrs =3D backtrace(frames, G_N_ELEMENTS(frames));
    fprintf(stderr, "Last %d frames:\n", n_ptrs);
    fprintf(stderr, "Offset is %d:\n", offset);

    backtrace_symbols_fd(frames, n_ptrs, STDERR_FILENO);
    ofono_error("++++++++++++++++++++++++++++++++++++++++");
}

With above modification, I am able to get backtrace but it only prints
address not the function names. Result is as below:

ofonod[2835]: ++++++++ backtrace +++++++++++++++++++++
Last 8 frames:
Offset is 2:
ofonod(+0xd5f60)[0x558a1a3f60]
ofonod(+0xd5ff4)[0x558a1a3ff4]
linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0x7f9cfa36c0]
ofonod(+0x3b614)[0x558a109614]
ofonod(ofono_modem_set_powered+0xe8)[0x558a1a6b18]
ofonod(+0x38548)[0x558a106548]
ofonod(+0x39548)[0x558a107548]
/usr/lib64/libglib-2.0.so.0(g_main_context_dispatch+0x114)[0x7f9ce8eed4]
ofonod[2835]: ++++++++++++++++++++++++++++++++++++++++

Can some one help me what is missing and how can I resolve the issue ?

-Best Regards,
Rohit Agrawal

--===============5086757873089267273==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpIEFsbCw8YnI+PGJyPjwvZGl2PkkgYW0gdHJ5aW5n
IHRvIHJ1biBPZm9ubyBvbiBhIEFSTSBiYXNlZCBBUCBwcm9jZXNzb3IuIFRoZSBiYWNrdHJhY2Ug
ZnVuY3Rpb24gd2hpY2ggaXMgcHJlc2VudCBpbiBPZm9ubyBpcyBub3Qgd29ya2luZyBvbiB0aGF0
IFByb2Nlc3NvciB0aG91Z2ggSSBoYXZlIGRvbmUgZm9sbG93aW5nOjxicj48L2Rpdj48ZGl2Pjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+RW5hYmxlZCAtLSAmZ3Q7IGVuYWJsZS1kZWJ1ZyBvcHRp
b248YnI+PC9kaXY+PGRpdj5FbmFibGVkIC1mdW53aW5kX3RhYmxlcyBvcHRpb24gaW4gQ0NfRkxB
R1Mgd2l0aGluIGVuYWJsZS1kZWJ1ZyBvcHRpb24gaXRzZWxmICg8YSBocmVmPSJodHRwOi8vY29u
ZmlndXJlLmFjIj5jb25maWd1cmUuYWM8L2E+KTxicj48L2Rpdj48ZGl2PlByb3ZpZGVkIC1yZHlu
YW1pYyBvcHRpb24gaW4gTERfRkxBR1Mgd2l0aGluIGVuYWJsZS1kZWJ1ZyBvcHRpb24gaXRzZWxk
ICg8YSBocmVmPSJodHRwOi8vY29uZmlndXJlLmFjIj5jb25maWd1cmUuYWM8L2E+KTxicj48YnI+
PC9kaXY+PGRpdj5zcmMvbG9nLmM8YnI+c3RhdGljIHZvaWQgcHJpbnRfYmFja3RyYWNlKHVuc2ln
bmVkIGludCBvZmZzZXQpPGJyPns8YnI+d3JpdHRlbiA9IHdyaXRlKG91dGZkWzFdLCBhZGRyLCBs
ZW4pOyAtLSZndDtUaGlzIGxpbmUgaXMgZmFpbGluZyBhbGwgdGhlIHRpbWUuPGJyPn08YnI+PGJy
PjwvZGl2PjxkaXY+SSBtb2RpZmllZCB0aGUgcHJpbnRfYmFja3RyYWNlKCkgdG8gYmVsb3c6PGJy
Pjxicj48L2Rpdj48ZGl2PnN0YXRpYyB2b2lkIHByaW50X2JhY2t0cmFjZSh1bnNpZ25lZCBpbnQg
b2Zmc2V0KTxicj57PGJyPsKgwqDCoCB2b2lkICpmcmFtZXNbOTldOzxicj7CoMKgwqAgc2l6ZV90
IG5fcHRyczs8YnI+wqDCoMKgIC8vdW5zaWduZWQgaW50IGk7PGJyPsKgwqDCoCAvL2ludCBvdXRm
ZFsyXSwgaW5mZFsyXTs8YnI+wqDCoMKgIGludCBwYXRobGVuOzxicj7CoMKgwqAgLy9waWRfdCBw
aWQ7PGJyPjxicj7CoMKgwqAgaWYgKHByb2dyYW1fZXhlYyA9PSBOVUxMKTxicj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjs8YnI+PGJyPsKgwqDCoCBwYXRobGVuID0gc3RybGVuKHByb2dy
YW1fcGF0aCk7PGJyPsKgwqDCoCBvZm9ub19lcnJvcigmcXVvdDsrKysrKysrKyBiYWNrdHJhY2Ug
KysrKysrKysrKysrKysrKysrKysrJnF1b3Q7KTs8YnI+PGJyPsKgwqDCoCBuX3B0cnMgPSBiYWNr
dHJhY2UoZnJhbWVzLCBHX05fRUxFTUVOVFMoZnJhbWVzKSk7PGJyPsKgwqDCoCBmcHJpbnRmKHN0
ZGVyciwgJnF1b3Q7TGFzdCAlZCBmcmFtZXM6XG4mcXVvdDssIG5fcHRycyk7PGJyPsKgwqDCoCBm
cHJpbnRmKHN0ZGVyciwgJnF1b3Q7T2Zmc2V0IGlzICVkOlxuJnF1b3Q7LCBvZmZzZXQpOzxicj48
YnI+wqDCoMKgIGJhY2t0cmFjZV9zeW1ib2xzX2ZkKGZyYW1lcywgbl9wdHJzLCBTVERFUlJfRklM
RU5PKTs8YnI+wqDCoMKgIG9mb25vX2Vycm9yKCZxdW90OysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysmcXVvdDspOzxicj59PGJyPjxicj48L2Rpdj48ZGl2PldpdGggYWJv
dmUgbW9kaWZpY2F0aW9uLCBJIGFtIGFibGUgdG8gZ2V0IGJhY2t0cmFjZSBidXQgaXQgb25seSBw
cmludHMgYWRkcmVzcyBub3QgdGhlIGZ1bmN0aW9uIG5hbWVzLiBSZXN1bHQgaXMgYXMgYmVsb3c6
PGJyPjxicj5vZm9ub2RbMjgzNV06ICsrKysrKysrIGJhY2t0cmFjZSArKysrKysrKysrKysrKysr
KysrKys8YnI+TGFzdCA4IGZyYW1lczo8YnI+T2Zmc2V0IGlzIDI6PGJyPm9mb25vZCgrMHhkNWY2
MClbMHg1NThhMWEzZjYwXTxicj5vZm9ub2QoKzB4ZDVmZjQpWzB4NTU4YTFhM2ZmNF08YnI+bGlu
dXgtdmRzby5zby4xKF9fa2VybmVsX3J0X3NpZ3JldHVybisweDApWzB4N2Y5Y2ZhMzZjMF08YnI+
b2Zvbm9kKCsweDNiNjE0KVsweDU1OGExMDk2MTRdPGJyPm9mb25vZChvZm9ub19tb2RlbV9zZXRf
cG93ZXJlZCsweGU4KVsweDU1OGExYTZiMThdPGJyPm9mb25vZCgrMHgzODU0OClbMHg1NThhMTA2
NTQ4XTxicj5vZm9ub2QoKzB4Mzk1NDgpWzB4NTU4YTEwNzU0OF08YnI+L3Vzci9saWI2NC9saWJn
bGliLTIuMC5zby4wKGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoKzB4MTE0KVsweDdmOWNlOGVlZDRd
PGJyPm9mb25vZFsyODM1XTogKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kzxicj48YnI+PC9kaXY+PGRpdj5DYW4gc29tZSBvbmUgaGVscCBtZSB3aGF0IGlzIG1pc3Npbmcg
YW5kIGhvdyBjYW4gSSByZXNvbHZlIHRoZSBpc3N1ZSA/PGJyPjxicj48L2Rpdj48ZGl2Pi1CZXN0
IFJlZ2FyZHMsPGJyPjwvZGl2PjxkaXY+Um9oaXQgQWdyYXdhbDxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48L2Rpdj4K

--===============5086757873089267273==--

