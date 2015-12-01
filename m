Content-Type: multipart/mixed; boundary="===============4772408475881079940=="
MIME-Version: 1.0
From: Fabio <fabio.tosetti@gmail.com>
Subject: Re: U-Blox modem sends unprintable chars before "AT+CGMS=<seq>"
 reply: ofono (1.16) close the serial port ?
Date: Tue, 01 Dec 2015 11:43:23 +0100
Message-ID: <CAJvjxszQ5R6ms2mRnndFJ2xphv-K+Rr5LxW=Pxx7nCdFr+0P3Q@mail.gmail.com>
In-Reply-To: <565B726D.4080506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4772408475881079940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

You are right, it was my misunderstanding.

What actually happens is that some layer under ofono (maybe the acm-adc
driver of our "old" kernel 2.6.37), detects an error in the communication
and close the port: simply ofono gets an HUP error on the "modem" port and
stop receving any data.
I don't think this issue should be resolved in ofono.

FabioT

_

On Sun, Nov 29, 2015 at 10:47 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Fabio,
>
> On 11/24/2015 03:45 AM, Fabio wrote:
>
>> Hello,
>> I'm using ofono 1.16 with some patch to add sms manager to the Ublox
>> driver.
>>
>> Someone could confirm that ofono close the serial port when it receives
>> some unexpected/unprintable character before the "AT+CGMS=3D<seq>" reply
>> from the modem?
>>
>
> No, oFono does not close serial ports because of garbage.  The syntax will
> generally discard / ignore AT commands that are not properly formatted.
>
>
>> If yes, is possible to discard these characters instead of hanging-up
>> the serial port? Could I have some info about the source I have to patch=
 ?
>>
>>
> Feel free to provide AT command logs to help us better understand what is
> happening.
>
> Regards,
> -Denis
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>



-- =

***************************************************************************=
*************************************************

"Solo due cose sono infinite: l'universo e la stupidit=C3=A0 umana. Ma della
prima non sono sicuro". [Albert Einstein]
***************************************************************************=
*************************************************

--===============4772408475881079940==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+WW91IGFyZSByaWdodCwgaXQgd2FzIG15IG1pc3VuZGVyc3RhbmRpbmcu
PGRpdj48YnI+PGRpdj5XaGF0IGFjdHVhbGx5IGhhcHBlbnMgaXMgdGhhdCBzb21lIGxheWVyIHVu
ZGVyIG9mb25vIChtYXliZSB0aGUgYWNtLWFkYyBkcml2ZXIgb2Ygb3VyICZxdW90O29sZCZxdW90
OyBrZXJuZWwgMi42LjM3KSwgZGV0ZWN0cyBhbiBlcnJvciBpbiB0aGUgY29tbXVuaWNhdGlvbiBh
bmQgY2xvc2UgdGhlIHBvcnQ6IHNpbXBseSBvZm9ubyBnZXRzIGFuIEhVUCBlcnJvciBvbiB0aGUg
JnF1b3Q7bW9kZW0mcXVvdDsgcG9ydCBhbmQgc3RvcCByZWNldmluZyBhbnkgZGF0YS48L2Rpdj48
ZGl2PkkgZG9uJiMzOTt0IHRoaW5rIHRoaXMgaXNzdWUgc2hvdWxkIGJlIHJlc29sdmVkIGluIG9m
b25vLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+RmFiaW9UPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5fPC9kaXY+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gU3VuLCBOb3YgMjksIDIwMTUgYXQgMTA6NDcgUE0sIERl
bmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBn
bWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFu
PiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
SGkgRmFiaW8sPHNwYW4gY2xhc3M9IiI+PGJyPgo8YnI+Ck9uIDExLzI0LzIwMTUgMDM6NDUgQU0s
IEZhYmlvIHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+CkhlbGxvLDxicj4KSSYjMzk7bSB1c2luZyBvZm9ubyAxLjE2IHdpdGggc29tZSBwYXRj
aCB0byBhZGQgc21zIG1hbmFnZXIgdG8gdGhlIFVibG94IGRyaXZlci48YnI+Cjxicj4KU29tZW9u
ZSBjb3VsZCBjb25maXJtIHRoYXQgb2Zvbm8gY2xvc2UgdGhlIHNlcmlhbCBwb3J0IHdoZW4gaXQg
cmVjZWl2ZXM8YnI+CnNvbWUgdW5leHBlY3RlZC91bnByaW50YWJsZSBjaGFyYWN0ZXIgYmVmb3Jl
IHRoZSAmcXVvdDtBVCtDR01TPSZsdDtzZXEmZ3Q7JnF1b3Q7IHJlcGx5PGJyPgpmcm9tIHRoZSBt
b2RlbT88YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvc3Bhbj4KTm8sIG9Gb25vIGRvZXMgbm90IGNs
b3NlIHNlcmlhbCBwb3J0cyBiZWNhdXNlIG9mIGdhcmJhZ2UuwqAgVGhlIHN5bnRheCB3aWxsIGdl
bmVyYWxseSBkaXNjYXJkIC8gaWdub3JlIEFUIGNvbW1hbmRzIHRoYXQgYXJlIG5vdCBwcm9wZXJs
eSBmb3JtYXR0ZWQuPHNwYW4gY2xhc3M9IiI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CklmIHllcywgaXMgcG9zc2libGUgdG8gZGlz
Y2FyZCB0aGVzZSBjaGFyYWN0ZXJzIGluc3RlYWQgb2YgaGFuZ2luZy11cDxicj4KdGhlIHNlcmlh
bCBwb3J0PyBDb3VsZCBJIGhhdmUgc29tZSBpbmZvIGFib3V0IHRoZSBzb3VyY2UgSSBoYXZlIHRv
IHBhdGNoID88YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpGZWVsIGZyZWUgdG8g
cHJvdmlkZSBBVCBjb21tYW5kIGxvZ3MgdG8gaGVscCB1cyBiZXR0ZXIgdW5kZXJzdGFuZCB3aGF0
IGlzIGhhcHBlbmluZy48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPGJyPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFp
bGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9i
bGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9u
by5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48
YnI+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2
Pi0tIDxicj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogPGJyPiZxdW90
O1NvbG8gZHVlIGNvc2Ugc29ubyBpbmZpbml0ZTogbCYjMzk7dW5pdmVyc28gZSBsYSBzdHVwaWRp
dMOgIHVtYW5hLiBNYSBkZWxsYSBwcmltYSBub24gc29ubyBzaWN1cm8mcXVvdDsuIFtBbGJlcnQg
RWluc3RlaW5dPGJyPioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKio8L2Rpdj4KPC9kaXY+Cg==

--===============4772408475881079940==--

