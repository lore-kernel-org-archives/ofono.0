Content-Type: multipart/mixed; boundary="===============3676256508141475374=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 28 Mar 2013 16:42:51 +0100
Message-ID: <CAAs3wMijW_8Cm9Af673zHjLBvvg4ZshWLcBrLuiiVfxKyTyVMQ@mail.gmail.com>
In-Reply-To: <51545398.4040108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3676256508141475374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2013/3/28 Denis Kenzior <denkenz@gmail.com>

> Hi,
>
> Please do not top-post on this mailing list.
>
>
> On 03/28/2013 08:43 AM, Freedreamer wrote:
>
>> sorry did not over the mail....
>>
>> about ppp , Is that normal that I have to config these parameters?
>>
>>
> Yes, this is normal.  oFono expects another daemon (e.g. ConnMan,
> NetworkManager) to configure the network interfaces.
>
> Regards,
> -Denis
>
>
Hi guys,

Sorry again! I'm a newbie in mailing list.
Thanks for ppp issue I understand. I tried my code (that worked on x86) on
the embedded ARM  board but we have problem , here the logs:
ofonod[16939]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90,
00, 15
ofonod[16939]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 15
ofonod[16939]: MUX: waking up writer
ofonod[16939]: MUX: creating source: 0x14a0390, channel: 0x148a6a0, writer:
4, reader: 0
ofonod[16939]: MUX: can write data
ofonod[16939]: MUX: checking channel for write: 0x148ac50
ofonod[16939]: MUX: checking channel for write: 0x148a6a0
ofonod[16939]: MUX: dispatching write sources: 0x148a6a0
ofonod[16939]: MUX: checking source: 0x14a0390
ofonod[16939]: MUX: dispatching source: 0x14a0390
ofonod[16939]: Chat2: > AT+CRSM=3D192,28474\r
ofonod[16939]: MUX: removing source: 0x14a0390
ofonod[16939]: MUX: checking source: 0x149eb80
ofonod[16939]: MUX: checking channel for write: 0x1488ec0
ofonod[16939]: MUX: dispatching write sources: 0x1488ec0
ofonod[16939]: MUX: checking source: 0x148aaf0
ofonod[16939]: MUX: checking channel for write: 0x1490430
ofonod[16939]: MUX: dispatching write sources: 0x1490430
ofonod[16939]: MUX: checking source: 0x148ad60
ofonod[16939]: Chat1: Wakeup got no response
ofonod[16939]: Aborting (signal 11) [ofonod]
ofonod[16939]: ++++++++ backtrace ++++++++

I suspect that should be a syncronization issue between the virtual
channel. Any idea?

--===============3676256508141475374==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMy8zLzI4IERlbmlzIEtlbnppb3Ig
PHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXIt
bGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KSGksPGJyPgo8YnI+ClBsZWFz
ZSBkbyBub3QgdG9wLXBvc3Qgb24gdGhpcyBtYWlsaW5nIGxpc3QuPGRpdiBjbGFzcz0iaW0iPjxi
cj4KPGJyPgpPbiAwMy8yOC8yMDEzIDA4OjQzIEFNLCBGcmVlZHJlYW1lciB3cm90ZTo8YnI+Cjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2Jv
cmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgpzb3JyeSBkaWQgbm90
IG92ZXIgdGhlIG1haWwuLi4uPGJyPgo8YnI+CmFib3V0IHBwcCAsIElzIHRoYXQgbm9ybWFsIHRo
YXQgSSBoYXZlIHRvIGNvbmZpZyB0aGVzZSBwYXJhbWV0ZXJzPzxicj4KPGJyPgo8L2Jsb2NrcXVv
dGU+Cjxicj48L2Rpdj4KWWVzLCB0aGlzIGlzIG5vcm1hbC4goG9Gb25vIGV4cGVjdHMgYW5vdGhl
ciBkYWVtb24gKGUuZy4gQ29ubk1hbiwgTmV0d29ya01hbmFnZXIpIHRvIGNvbmZpZ3VyZSB0aGUg
bmV0d29yayBpbnRlcmZhY2VzLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8YnI+
CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+SGkgZ3V5cyw8YnI+PGJyPlNvcnJ5IGFnYWluISBJJiMz
OTttIGEgbmV3YmllIGluIG1haWxpbmcgbGlzdC4gPGJyPlRoYW5rcyBmb3IgcHBwIGlzc3VlIEkg
dW5kZXJzdGFuZC4gSSB0cmllZCBteSBjb2RlICh0aGF0IHdvcmtlZCBvbiB4ODYpIG9uIHRoZSBl
bWJlZGRlZCBBUk2gIGJvYXJkIGJ1dCB3ZSBoYXZlIHByb2JsZW0gLCBoZXJlIHRoZSBsb2dzOjxi
cj4Kb2Zvbm9kWzE2OTM5XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigp
IGNyc21fcmVhZF9jYjogOTAsIDAwLCAxNTxicj5vZm9ub2RbMTY5MzldOiBzcmMvc2ltZnMuYzpz
aW1fZnNfb3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAx
NTxicj5vZm9ub2RbMTY5MzldOiBNVVg6IHdha2luZyB1cCB3cml0ZXI8YnI+b2Zvbm9kWzE2OTM5
XTogTVVYOiBjcmVhdGluZyBzb3VyY2U6IDB4MTRhMDM5MCwgY2hhbm5lbDogMHgxNDhhNmEwLCB3
cml0ZXI6IDQsIHJlYWRlcjogMDxicj4Kb2Zvbm9kWzE2OTM5XTogTVVYOiBjYW4gd3JpdGUgZGF0
YTxicj5vZm9ub2RbMTY5MzldOiBNVVg6IGNoZWNraW5nIGNoYW5uZWwgZm9yIHdyaXRlOiAweDE0
OGFjNTA8YnI+b2Zvbm9kWzE2OTM5XTogTVVYOiBjaGVja2luZyBjaGFubmVsIGZvciB3cml0ZTog
MHgxNDhhNmEwPGJyPm9mb25vZFsxNjkzOV06IE1VWDogZGlzcGF0Y2hpbmcgd3JpdGUgc291cmNl
czogMHgxNDhhNmEwPGJyPm9mb25vZFsxNjkzOV06IE1VWDogY2hlY2tpbmcgc291cmNlOiAweDE0
YTAzOTA8YnI+Cm9mb25vZFsxNjkzOV06IE1VWDogZGlzcGF0Y2hpbmcgc291cmNlOiAweDE0YTAz
OTA8YnI+b2Zvbm9kWzE2OTM5XTogQ2hhdDI6ICZndDsgQVQrQ1JTTT0xOTIsMjg0NzRccjxicj5v
Zm9ub2RbMTY5MzldOiBNVVg6IHJlbW92aW5nIHNvdXJjZTogMHgxNGEwMzkwPGJyPm9mb25vZFsx
NjkzOV06IE1VWDogY2hlY2tpbmcgc291cmNlOiAweDE0OWViODA8YnI+b2Zvbm9kWzE2OTM5XTog
TVVYOiBjaGVja2luZyBjaGFubmVsIGZvciB3cml0ZTogMHgxNDg4ZWMwPGJyPgpvZm9ub2RbMTY5
MzldOiBNVVg6IGRpc3BhdGNoaW5nIHdyaXRlIHNvdXJjZXM6IDB4MTQ4OGVjMDxicj5vZm9ub2Rb
MTY5MzldOiBNVVg6IGNoZWNraW5nIHNvdXJjZTogMHgxNDhhYWYwPGJyPm9mb25vZFsxNjkzOV06
IE1VWDogY2hlY2tpbmcgY2hhbm5lbCBmb3Igd3JpdGU6IDB4MTQ5MDQzMDxicj5vZm9ub2RbMTY5
MzldOiBNVVg6IGRpc3BhdGNoaW5nIHdyaXRlIHNvdXJjZXM6IDB4MTQ5MDQzMDxicj4Kb2Zvbm9k
WzE2OTM5XTogTVVYOiBjaGVja2luZyBzb3VyY2U6IDB4MTQ4YWQ2MDxicj5vZm9ub2RbMTY5Mzld
OiBDaGF0MTogV2FrZXVwIGdvdCBubyByZXNwb25zZTxicj5vZm9ub2RbMTY5MzldOiBBYm9ydGlu
ZyAoc2lnbmFsIDExKSBbb2Zvbm9kXTxicj5vZm9ub2RbMTY5MzldOiArKysrKysrKyBiYWNrdHJh
Y2UgKysrKysrKys8YnI+PGJyPkkgc3VzcGVjdCB0aGF0IHNob3VsZCBiZSBhIHN5bmNyb25pemF0
aW9uIGlzc3VlIGJldHdlZW4gdGhlIHZpcnR1YWwgY2hhbm5lbC4gQW55IGlkZWE/PGJyPgo8YnI+
PGJyPjxicj4K

--===============3676256508141475374==--

