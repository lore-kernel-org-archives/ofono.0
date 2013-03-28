Content-Type: multipart/mixed; boundary="===============3854623420199772071=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 28 Mar 2013 17:32:50 +0100
Message-ID: <CAAs3wMjr-0xrGo_JML1ZtDLqd+Dt_=VYXTy8Ob3nK8RMWGEXeg@mail.gmail.com>
In-Reply-To: <CAAs3wMijW_8Cm9Af673zHjLBvvg4ZshWLcBrLuiiVfxKyTyVMQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3854623420199772071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2013/3/28 Freedreamer <freedreamer@email.it>

>
>
> 2013/3/28 Denis Kenzior <denkenz@gmail.com>
>
>> Hi,
>>
>> Please do not top-post on this mailing list.
>>
>>
>> On 03/28/2013 08:43 AM, Freedreamer wrote:
>>
>>> sorry did not over the mail....
>>>
>>> about ppp , Is that normal that I have to config these parameters?
>>>
>>>
>> Yes, this is normal.  oFono expects another daemon (e.g. ConnMan,
>> NetworkManager) to configure the network interfaces.
>>
>> Regards,
>> -Denis
>>
>>
> Hi guys,
>
> Sorry again! I'm a newbie in mailing list.
> Thanks for ppp issue I understand. I tried my code (that worked on x86) on
> the embedded ARM  board but we have problem , here the logs:
> ofonod[16939]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
> 00, 15
> ofonod[16939]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff:
> 0, tocopy: 15
> ofonod[16939]: MUX: waking up writer
> ofonod[16939]: MUX: creating source: 0x14a0390, channel: 0x148a6a0,
> writer: 4, reader: 0
> ofonod[16939]: MUX: can write data
> ofonod[16939]: MUX: checking channel for write: 0x148ac50
> ofonod[16939]: MUX: checking channel for write: 0x148a6a0
> ofonod[16939]: MUX: dispatching write sources: 0x148a6a0
> ofonod[16939]: MUX: checking source: 0x14a0390
> ofonod[16939]: MUX: dispatching source: 0x14a0390
> ofonod[16939]: Chat2: > AT+CRSM=3D192,28474\r
> ofonod[16939]: MUX: removing source: 0x14a0390
> ofonod[16939]: MUX: checking source: 0x149eb80
> ofonod[16939]: MUX: checking channel for write: 0x1488ec0
> ofonod[16939]: MUX: dispatching write sources: 0x1488ec0
> ofonod[16939]: MUX: checking source: 0x148aaf0
> ofonod[16939]: MUX: checking channel for write: 0x1490430
> ofonod[16939]: MUX: dispatching write sources: 0x1490430
> ofonod[16939]: MUX: checking source: 0x148ad60
> ofonod[16939]: Chat1: Wakeup got no response
> ofonod[16939]: Aborting (signal 11) [ofonod]
> ofonod[16939]: ++++++++ backtrace ++++++++
>
> I suspect that should be a syncronization issue between the virtual
> channel. Any idea?
>
>
> Hi ,
got new information. I start gdb and backtrace and i found where is the seg
fault. The function   "decode_at_error"  doesn't check if *error or *final
are NULL... and in my case they are.
if  I put a check in the function it remains stuck waiting AT cmd reply....

any help is appreciated.

Marco

below the logs:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff7dbb740 (LWP 13322)]
0x000000000045d1be in decode_at_error ()
Missing separate debuginfos, use: debuginfo-install
bluez-libs-4.101-6.fc18.x86_64 dbus-libs-1.6.8-2.fc18.x86_64
glib2-2.34.2-2.fc18.x86_64 glibc-2.16-28.fc18.x86_64
libgcc-4.7.2-8.fc18.x86_64 systemd-libs-197-1.fc18.2.x86_64
(gdb) backtrace
#0  0x000000000045d1be in decode_at_error ()
#1  0x000000000045c6b0 in attr_cb ()
#2  0x000000000043fc28 in at_chat_finish_command ()
#3  0x000000000043fcb9 in wakeup_no_response ()
#4  0x00000034e56485db in g_timeout_dispatch () from /lib64/libglib-2.0.so.0
#5  0x00000034e5647a55 in g_main_context_dispatch () from
/lib64/libglib-2.0.so.0
#6  0x00000034e5647d88 in g_main_context_iterate.isra.24 () from
/lib64/libglib-2.0.so.0
#7  0x00000034e5648182 in g_main_loop_run () from /lib64/libglib-2.0.so.0
#8  0x000000000040f5f2 in main ()



ofonod[16255]: MUX: received data
ofonod[16255]: MUX: deliver_data: dlc: 4
ofonod[16255]: MUX: dispatching sources for channel: 0xdd98b0
ofonod[16255]: MUX: checking source: 0xdd9980
ofonod[16255]: MUX: dispatching source: 0xdd9980
ofonod[16255]: Chat4: < \r\n+CGEV: NW DETACH\r\n
ofonod[16255]: Chat1: Wakeup got no response
ofonod[16255]: drivers/atmodem/atutil.c:decode_at_error() decode_at_error
null pointer
ofonod[16255]: Chat1: Wakeup got no response
ofonod[16255]: Chat1: Wakeup got no response
ofonod[16255]: Chat1: Wakeup got no response
ofonod[16255]: Chat1: Wakeup got no response
ofonod[16255]: Chat1: Wakeup got no response

--===============3854623420199772071==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMy8zLzI4IEZyZWVkcmVhbWVyIDxz
cGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmZyZWVkcmVhbWVyQGVtYWlsLml0IiB0
YXJnZXQ9Il9ibGFuayI+ZnJlZWRyZWFtZXJAZW1haWwuaXQ8L2E+Jmd0Ozwvc3Bhbj48YnI+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CjxkaXYgY2xhc3M9IkhP
RW5aYiI+PGRpdiBjbGFzcz0iaDUiPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIw
MTMvMy8yOCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRv
OmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+
Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+CgpIaSw8YnI+Cjxicj4KUGxlYXNlIGRvIG5vdCB0b3AtcG9zdCBvbiB0aGlzIG1haWxpbmcg
bGlzdC48ZGl2Pjxicj4KPGJyPgpPbiAwMy8yOC8yMDEzIDA4OjQzIEFNLCBGcmVlZHJlYW1lciB3
cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpz
b3JyeSBkaWQgbm90IG92ZXIgdGhlIG1haWwuLi4uPGJyPgo8YnI+CmFib3V0IHBwcCAsIElzIHRo
YXQgbm9ybWFsIHRoYXQgSSBoYXZlIHRvIGNvbmZpZyB0aGVzZSBwYXJhbWV0ZXJzPzxicj4KPGJy
Pgo8L2Jsb2NrcXVvdGU+Cjxicj48L2Rpdj4KWWVzLCB0aGlzIGlzIG5vcm1hbC4goG9Gb25vIGV4
cGVjdHMgYW5vdGhlciBkYWVtb24gKGUuZy4gQ29ubk1hbiwgTmV0d29ya01hbmFnZXIpIHRvIGNv
bmZpZ3VyZSB0aGUgbmV0d29yayBpbnRlcmZhY2VzLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURl
bmlzPGJyPgo8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+SGkgZ3V5cyw8
YnI+PGJyPlNvcnJ5IGFnYWluISBJJiMzOTttIGEgbmV3YmllIGluIG1haWxpbmcgbGlzdC4gPGJy
PlRoYW5rcyBmb3IgcHBwIGlzc3VlIEkgdW5kZXJzdGFuZC4gSSB0cmllZCBteSBjb2RlICh0aGF0
IHdvcmtlZCBvbiB4ODYpIG9uIHRoZSBlbWJlZGRlZCBBUk2gIGJvYXJkIGJ1dCB3ZSBoYXZlIHBy
b2JsZW0gLCBoZXJlIHRoZSBsb2dzOjxicj4KCm9mb25vZFsxNjkzOV06IGRyaXZlcnMvYXRtb2Rl
bS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTU8YnI+b2Zv
bm9kWzE2OTM5XTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6
IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTU8YnI+b2Zvbm9kWzE2OTM5XTogTVVYOiB3YWtpbmcg
dXAgd3JpdGVyPGJyPm9mb25vZFsxNjkzOV06IE1VWDogY3JlYXRpbmcgc291cmNlOiAweDE0YTAz
OTAsIGNoYW5uZWw6IDB4MTQ4YTZhMCwgd3JpdGVyOiA0LCByZWFkZXI6IDA8YnI+CgpvZm9ub2Rb
MTY5MzldOiBNVVg6IGNhbiB3cml0ZSBkYXRhPGJyPm9mb25vZFsxNjkzOV06IE1VWDogY2hlY2tp
bmcgY2hhbm5lbCBmb3Igd3JpdGU6IDB4MTQ4YWM1MDxicj5vZm9ub2RbMTY5MzldOiBNVVg6IGNo
ZWNraW5nIGNoYW5uZWwgZm9yIHdyaXRlOiAweDE0OGE2YTA8YnI+b2Zvbm9kWzE2OTM5XTogTVVY
OiBkaXNwYXRjaGluZyB3cml0ZSBzb3VyY2VzOiAweDE0OGE2YTA8YnI+Cm9mb25vZFsxNjkzOV06
IE1VWDogY2hlY2tpbmcgc291cmNlOiAweDE0YTAzOTA8YnI+Cm9mb25vZFsxNjkzOV06IE1VWDog
ZGlzcGF0Y2hpbmcgc291cmNlOiAweDE0YTAzOTA8YnI+b2Zvbm9kWzE2OTM5XTogQ2hhdDI6ICZn
dDsgQVQrQ1JTTT0xOTIsMjg0NzRccjxicj5vZm9ub2RbMTY5MzldOiBNVVg6IHJlbW92aW5nIHNv
dXJjZTogMHgxNGEwMzkwPGJyPm9mb25vZFsxNjkzOV06IE1VWDogY2hlY2tpbmcgc291cmNlOiAw
eDE0OWViODA8YnI+b2Zvbm9kWzE2OTM5XTogTVVYOiBjaGVja2luZyBjaGFubmVsIGZvciB3cml0
ZTogMHgxNDg4ZWMwPGJyPgoKb2Zvbm9kWzE2OTM5XTogTVVYOiBkaXNwYXRjaGluZyB3cml0ZSBz
b3VyY2VzOiAweDE0ODhlYzA8YnI+b2Zvbm9kWzE2OTM5XTogTVVYOiBjaGVja2luZyBzb3VyY2U6
IDB4MTQ4YWFmMDxicj5vZm9ub2RbMTY5MzldOiBNVVg6IGNoZWNraW5nIGNoYW5uZWwgZm9yIHdy
aXRlOiAweDE0OTA0MzA8YnI+b2Zvbm9kWzE2OTM5XTogTVVYOiBkaXNwYXRjaGluZyB3cml0ZSBz
b3VyY2VzOiAweDE0OTA0MzA8YnI+CgpvZm9ub2RbMTY5MzldOiBNVVg6IGNoZWNraW5nIHNvdXJj
ZTogMHgxNDhhZDYwPGJyPm9mb25vZFsxNjkzOV06IENoYXQxOiBXYWtldXAgZ290IG5vIHJlc3Bv
bnNlPGJyPm9mb25vZFsxNjkzOV06IEFib3J0aW5nIChzaWduYWwgMTEpIFtvZm9ub2RdPGJyPm9m
b25vZFsxNjkzOV06ICsrKysrKysrIGJhY2t0cmFjZSArKysrKysrKzxicj48YnI+SSBzdXNwZWN0
IHRoYXQgc2hvdWxkIGJlIGEgc3luY3Jvbml6YXRpb24gaXNzdWUgYmV0d2VlbiB0aGUgdmlydHVh
bCBjaGFubmVsLiBBbnkgaWRlYT88YnI+Cgo8YnI+PGJyPjwvYmxvY2txdW90ZT48ZGl2PkhpICw8
YnI+Z290IG5ldyBpbmZvcm1hdGlvbi4gSSBzdGFydCBnZGIgYW5kIGJhY2t0cmFjZSBhbmQgaSBm
b3VuZCB3aGVyZSBpcyB0aGUgc2VnIGZhdWx0LiBUaGUgZnVuY3Rpb26goCAmcXVvdDtkZWNvZGVf
YXRfZXJyb3ImcXVvdDugIGRvZXNuJiMzOTt0IGNoZWNrIGlmICplcnJvciBvciAqZmluYWwgYXJl
IE5VTEwuLi4gYW5kIGluIG15IGNhc2UgdGhleSBhcmUuPGJyPgppZqAgSSBwdXQgYSBjaGVjayBp
biB0aGUgZnVuY3Rpb24gaXQgcmVtYWlucyBzdHVjayB3YWl0aW5nIEFUIGNtZCByZXBseS4uLi48
YnI+PGJyPmFueSBoZWxwIGlzIGFwcHJlY2lhdGVkLjxicj48YnI+TWFyY288YnI+PGJyPmJlbG93
IHRoZSBsb2dzOjxicj48YnI+UHJvZ3JhbSByZWNlaXZlZCBzaWduYWwgU0lHU0VHViwgU2VnbWVu
dGF0aW9uIGZhdWx0Ljxicj5bU3dpdGNoaW5nIHRvIFRocmVhZCAweDdmZmZmN2RiYjc0MCAoTFdQ
IDEzMzIyKV08YnI+CjB4MDAwMDAwMDAwMDQ1ZDFiZSBpbiBkZWNvZGVfYXRfZXJyb3IgKCk8YnI+
TWlzc2luZyBzZXBhcmF0ZSBkZWJ1Z2luZm9zLCB1c2U6IGRlYnVnaW5mby1pbnN0YWxsIGJsdWV6
LWxpYnMtNC4xMDEtNi5mYzE4Lng4Nl82NCBkYnVzLWxpYnMtMS42LjgtMi5mYzE4Lng4Nl82NCBn
bGliMi0yLjM0LjItMi5mYzE4Lng4Nl82NCBnbGliYy0yLjE2LTI4LmZjMTgueDg2XzY0IGxpYmdj
Yy00LjcuMi04LmZjMTgueDg2XzY0IHN5c3RlbWQtbGlicy0xOTctMS5mYzE4LjIueDg2XzY0PGJy
PgooZ2RiKSBiYWNrdHJhY2U8YnI+IzCgIDB4MDAwMDAwMDAwMDQ1ZDFiZSBpbiBkZWNvZGVfYXRf
ZXJyb3IgKCk8YnI+IzGgIDB4MDAwMDAwMDAwMDQ1YzZiMCBpbiBhdHRyX2NiICgpPGJyPiMyoCAw
eDAwMDAwMDAwMDA0M2ZjMjggaW4gYXRfY2hhdF9maW5pc2hfY29tbWFuZCAoKTxicj4jM6AgMHgw
MDAwMDAwMDAwNDNmY2I5IGluIHdha2V1cF9ub19yZXNwb25zZSAoKTxicj4jNKAgMHgwMDAwMDAz
NGU1NjQ4NWRiIGluIGdfdGltZW91dF9kaXNwYXRjaCAoKSBmcm9tIC9saWI2NC9saWJnbGliLTIu
MC5zby4wPGJyPgojNaAgMHgwMDAwMDAzNGU1NjQ3YTU1IGluIGdfbWFpbl9jb250ZXh0X2Rpc3Bh
dGNoICgpIGZyb20gL2xpYjY0L2xpYmdsaWItMi4wLnNvLjA8YnI+IzagIDB4MDAwMDAwMzRlNTY0
N2Q4OCBpbiBnX21haW5fY29udGV4dF9pdGVyYXRlLmlzcmEuMjQgKCkgZnJvbSAvbGliNjQvbGli
Z2xpYi0yLjAuc28uMDxicj4jN6AgMHgwMDAwMDAzNGU1NjQ4MTgyIGluIGdfbWFpbl9sb29wX3J1
biAoKSBmcm9tIC9saWI2NC9saWJnbGliLTIuMC5zby4wPGJyPgojOKAgMHgwMDAwMDAwMDAwNDBm
NWYyIGluIG1haW4gKCk8YnI+PGJyPjxicj48YnI+b2Zvbm9kWzE2MjU1XTogTVVYOiByZWNlaXZl
ZCBkYXRhPGJyPm9mb25vZFsxNjI1NV06IE1VWDogZGVsaXZlcl9kYXRhOiBkbGM6IDQ8YnI+b2Zv
bm9kWzE2MjU1XTogTVVYOiBkaXNwYXRjaGluZyBzb3VyY2VzIGZvciBjaGFubmVsOiAweGRkOThi
MDxicj5vZm9ub2RbMTYyNTVdOiBNVVg6IGNoZWNraW5nIHNvdXJjZTogMHhkZDk5ODA8YnI+Cm9m
b25vZFsxNjI1NV06IE1VWDogZGlzcGF0Y2hpbmcgc291cmNlOiAweGRkOTk4MDxicj5vZm9ub2Rb
MTYyNTVdOiBDaGF0NDogJmx0OyBcclxuK0NHRVY6IE5XIERFVEFDSFxyXG48YnI+b2Zvbm9kWzE2
MjU1XTogQ2hhdDE6IFdha2V1cCBnb3Qgbm8gcmVzcG9uc2U8YnI+b2Zvbm9kWzE2MjU1XTogZHJp
dmVycy9hdG1vZGVtL2F0dXRpbC5jOmRlY29kZV9hdF9lcnJvcigpIGRlY29kZV9hdF9lcnJvciBu
dWxsIHBvaW50ZXI8YnI+Cm9mb25vZFsxNjI1NV06IENoYXQxOiBXYWtldXAgZ290IG5vIHJlc3Bv
bnNlPGJyPm9mb25vZFsxNjI1NV06IENoYXQxOiBXYWtldXAgZ290IG5vIHJlc3BvbnNlPGJyPm9m
b25vZFsxNjI1NV06IENoYXQxOiBXYWtldXAgZ290IG5vIHJlc3BvbnNlPGJyPm9mb25vZFsxNjI1
NV06IENoYXQxOiBXYWtldXAgZ290IG5vIHJlc3BvbnNlPGJyPm9mb25vZFsxNjI1NV06IENoYXQx
OiBXYWtldXAgZ290IG5vIHJlc3BvbnNlPGJyPgo8YnI+PC9kaXY+PC9kaXY+PGJyPgo=

--===============3854623420199772071==--

