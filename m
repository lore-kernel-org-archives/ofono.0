Content-Type: multipart/mixed; boundary="===============5387374897246790723=="
MIME-Version: 1.0
From: Freedreamer <freedreamer@email.it>
Subject: Re: SAGEM HiloNC v2 Driver
Date: Thu, 04 Apr 2013 14:08:42 +0200
Message-ID: <CAAs3wMg72S76Ltr66so0WxE1kbEXmeEkniBT6C6KBzQdVofb6A@mail.gmail.com>
In-Reply-To: <CAAs3wMiz-gTvWp4ZU3X1aJ25TLViKdirqQ3BQJiJC=hWoLN3tw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5387374897246790723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2013/3/29 Freedreamer <freedreamer@email.it>

> Hi,
>
>
> 2013/3/28 Denis Kenzior <denkenz@gmail.com>
>
>> Hi,
>>
>>
>>  Hi ,
>>> got new information. I start gdb and backtrace and i found where is the
>>> seg fault. The function "decode_at_error"  doesn't check if *error or
>>> *final are NULL... and in my case they are.
>>> if  I put a check in the function it remains stuck waiting AT cmd
>>> reply....
>>>
>>>
>> The wakeup logic should only be used with the Freerunner.  Please disable
>> it unless you know what you're doing.  Something else is wrong.
>>
>> Regards,
>> -Denis
>>
>
> Denis u were right... removing wakeup cmd it seems it works again also on
> the embedded board.Now i will work on ppp and connman integration.
>
> Thanks
>

I almost finished the driver..seems to work properly also on the embedded
device (just for SMS & PPP ). If I would like to share the code .. how
should I procede? would u like a patch posted here or a git  pull request ?
or what else ?

another issue  : anyone could explain what module should I see to properly
set the ppp0 interface once  got a valid IP from the PPP ?

Best regards.

Marco

--===============5387374897246790723==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMy8zLzI5IEZyZWVkcmVhbWVy
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmZyZWVkcmVhbWVyQGVtYWlsLml0
IiB0YXJnZXQ9Il9ibGFuayI+ZnJlZWRyZWFtZXJAZW1haWwuaXQ8L2E+Jmd0Ozwvc3Bhbj48YnI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CkhpLDxkaXY+PGRp
diBjbGFzcz0iaDUiPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTMvMy8yOCBE
ZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bh
bj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CgpIaSw8
ZGl2Pjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4KSGkgLDxicj4KZ290IG5ldyBpbmZvcm1hdGlvbi4gSSBzdGFydCBnZGIgYW5kIGJhY2t0cmFj
ZSBhbmQgaSBmb3VuZCB3aGVyZSBpcyB0aGU8YnI+CnNlZyBmYXVsdC4gVGhlIGZ1bmN0aW9uICZx
dW90O2RlY29kZV9hdF9lcnJvciZxdW90OyCgZG9lc24mIzM5O3QgY2hlY2sgaWYgKmVycm9yIG9y
PGJyPgoqZmluYWwgYXJlIE5VTEwuLi4gYW5kIGluIG15IGNhc2UgdGhleSBhcmUuPGJyPgppZiCg
SSBwdXQgYSBjaGVjayBpbiB0aGUgZnVuY3Rpb24gaXQgcmVtYWlucyBzdHVjayB3YWl0aW5nIEFU
IGNtZCByZXBseS4uLi48YnI+Cjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9kaXY+ClRoZSB3YWtl
dXAgbG9naWMgc2hvdWxkIG9ubHkgYmUgdXNlZCB3aXRoIHRoZSBGcmVlcnVubmVyLiCgUGxlYXNl
IGRpc2FibGUgaXQgdW5sZXNzIHlvdSBrbm93IHdoYXQgeW91JiMzOTtyZSBkb2luZy4goFNvbWV0
aGluZyBlbHNlIGlzIHdyb25nLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2PkRlbmlzIHUgd2VyZSByaWdodC4uLiByZW1v
dmluZyB3YWtldXAgY21kIGl0IHNlZW1zIGl0IHdvcmtzIGFnYWluIGFsc28gb24gdGhlIGVtYmVk
ZGVkIGJvYXJkLk5vdyBpIHdpbGwgd29yayBvbiBwcHAgYW5kIGNvbm5tYW4gaW50ZWdyYXRpb24u
IDxicj48YnI+VGhhbmtzIDxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48ZGl2PkkgYWxtb3N0
IGZpbmlzaGVkIHRoZSBkcml2ZXIuLnNlZW1zIHRvIHdvcmsgcHJvcGVybHkgYWxzbyBvbiB0aGUg
ZW1iZWRkZWQgZGV2aWNlIChqdXN0IGZvciBTTVMgJmFtcDsgUFBQICkuIElmIEkgd291bGQgbGlr
ZSB0byBzaGFyZSB0aGUgY29kZSAuLiBob3cgc2hvdWxkIEkgcHJvY2VkZT8gd291bGQgdSBsaWtl
IGEgcGF0Y2ggcG9zdGVkIGhlcmUgb3IgYSBnaXQgoHB1bGwgcmVxdWVzdCA/IG9yIHdoYXQgZWxz
ZSA/PC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+YW5vdGhlciBpc3N1ZSCgOiBhbnlvbmUgY291
bGQgZXhwbGFpbiB3aGF0IG1vZHVsZSBzaG91bGQgSSBzZWUgdG8gcHJvcGVybHkgc2V0IHRoZSBw
cHAwIGludGVyZmFjZSBvbmNlIKBnb3QgYSB2YWxpZCBJUCBmcm9tIHRoZSBQUFAgPzwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
TWFyY288L2Rpdj4K

--===============5387374897246790723==--

