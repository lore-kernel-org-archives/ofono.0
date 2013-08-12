Content-Type: multipart/mixed; boundary="===============4977616568745845572=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: Re: PPP connection to a private APN
Date: Mon, 12 Aug 2013 11:28:11 +0200
Message-ID: <CAAZAA2HzNt2JT8y-z+4+1=H2rkYNqRiODsB_-bD-0p-5MvyKRQ@mail.gmail.com>
In-Reply-To: <CAMtf1D_xxJtSppKribWFBi01beAsXowm5_jAp6+gqTtdjTMLGg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4977616568745845572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2013 at 11:19 AM, Etienne Mabille <mabille.etienne@gmail.=
com
> wrote:

> 2013/8/9 Denis Kenzior <denkenz@gmail.com>
>
>>
>
>
>>> Another topic is the authentication protocol. By default the Telit HE910
>>> uses PAP which is not handled by ofono.
>>> I started to implement it in gatchat/ppp_auth.c it is not quite perfect
>>> because it does not ask to do CHAP before falling back to PAP but if
>>> anyone
>>> is interested i would be glad to share the code.
>>> We then found out that there is a custom AT command for the Telit HE910
>>> that
>>> allows you to set the authentication protocol to use : AT#CGAUTH=3D[0,1,
>>> or 2]
>>> I added it in plugins/telit.c in the post_online function and stopped
>>> working on PAP. (I am using the telit rework patch provided by Jonas
>>> Bonn on
>>> the 4th of April)
>>>
>>
>> Does this work with CGDATA?  If that is the case it might explain why
>> CGDATA does not ask for authentication.  You can enable this command ins=
ide
>> drivers/atmodem/gprs-context.c with the appropriate OFONO_VENDOR handling
>> as well.
>>
>>
> The CGDATA does not work with the Telit modem, whatever the value of
> AT#CGAUTH is. In my case, ATD*99 is absolutely necessary. The CGAUTH
> command is just there to use CHAP instead of PAP because ofono doesn't
> handle it.
>
>
>> Patches are always welcome.
>>
>
> I am trying to do a clean patch in drivers/atmodem/gprs-context.c but for
> some reason the field gcd->vendor is equal to 0 so it doesn't match with
> OFONO_VENDOR_TELIT.
>


Vendor is set when creating the gprs context in telit_post_sim()
(plugins/tellit.c:561)

gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
data->chat);
gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);

You need to change the second argument from 0 to OFONO_VENDOR_TELIT



> The two AT commands are the following :
>
> // in at_gprs_activate_primary :
>
> if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT){
>     /*
>      * Set the modem to use CHAP authentication if needed.
>      * Telit modems use PAP by default which is not supported
>      * by ofono.
>      */
>      g_at_chat_send(gcd->chat, "AT#GAUTH=3D2", none_prefix, NULL, NULL,
> NULL);
> }
>
>
>
> // in  at_cgdcont_cb :
> if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT){
>     /*
>      * With Telit AT+CGDATA prevents the DCE from offering
>      * an authentication protocol, so we use this command in
>      * case we need to connect to a private APN.
>      */
>
>     sprintf(buf, "ATD*99***%u#", gcd->active_context);
> }
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>

--===============4977616568745845572==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBNb24sIEF1ZyAxMiwgMjAxMyBhdCAxMToxOSBBTSwgRXRp
ZW5uZSBNYWJpbGxlIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOm1hYmlsbGUu
ZXRpZW5uZUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYWJpbGxlLmV0aWVubmVAZ21haWwu
Y29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFw
eDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgY2xhc3M9ImdtYWlsX2V4
dHJhIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+CjxkaXYgY2xhc3M9ImltIj4yMDEzLzgvOSBE
ZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bh
bj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1zdHlsZTpzb2xp
ZDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgoK
CgoKCqA8L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVm
dC1zdHlsZTpzb2xpZDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxl
OnNvbGlkO2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+Cjxicj4KQW5vdGhlciB0b3BpYyBpcyB0aGUgYXV0aGVudGljYXRpb24gcHJvdG9jb2wuIEJ5
IGRlZmF1bHQgdGhlIFRlbGl0IEhFOTEwPGJyPgp1c2VzIFBBUCB3aGljaCBpcyBub3QgaGFuZGxl
ZCBieSBvZm9uby48YnI+Ckkgc3RhcnRlZCB0byBpbXBsZW1lbnQgaXQgaW4gZ2F0Y2hhdC9wcHBf
YXV0aC5jIGl0IGlzIG5vdCBxdWl0ZSBwZXJmZWN0PGJyPgpiZWNhdXNlIGl0IGRvZXMgbm90IGFz
ayB0byBkbyBDSEFQIGJlZm9yZSBmYWxsaW5nIGJhY2sgdG8gUEFQIGJ1dCBpZiBhbnlvbmU8YnI+
CmlzIGludGVyZXN0ZWQgaSB3b3VsZCBiZSBnbGFkIHRvIHNoYXJlIHRoZSBjb2RlLjxicj4KV2Ug
dGhlbiBmb3VuZCBvdXQgdGhhdCB0aGVyZSBpcyBhIGN1c3RvbSBBVCBjb21tYW5kIGZvciB0aGUg
VGVsaXQgSEU5MTAgdGhhdDxicj4KYWxsb3dzIHlvdSB0byBzZXQgdGhlIGF1dGhlbnRpY2F0aW9u
IHByb3RvY29sIHRvIHVzZSA6IEFUI0NHQVVUSD1bMCwxLCBvciAyXTxicj4KSSBhZGRlZCBpdCBp
biBwbHVnaW5zL3RlbGl0LmMgaW4gdGhlIHBvc3Rfb25saW5lIGZ1bmN0aW9uIGFuZCBzdG9wcGVk
PGJyPgp3b3JraW5nIG9uIFBBUC4gKEkgYW0gdXNpbmcgdGhlIHRlbGl0IHJld29yayBwYXRjaCBw
cm92aWRlZCBieSBKb25hcyBCb25uIG9uPGJyPgp0aGUgNHRoIG9mIEFwcmlsKTxicj4KPC9ibG9j
a3F1b3RlPgo8YnI+CkRvZXMgdGhpcyB3b3JrIHdpdGggQ0dEQVRBPyCgSWYgdGhhdCBpcyB0aGUg
Y2FzZSBpdCBtaWdodCBleHBsYWluIHdoeSBDR0RBVEEgZG9lcyBub3QgYXNrIGZvciBhdXRoZW50
aWNhdGlvbi4goFlvdSBjYW4gZW5hYmxlIHRoaXMgY29tbWFuZCBpbnNpZGUgZHJpdmVycy9hdG1v
ZGVtL2dwcnMtY29udGV4dC5jIHdpdGggdGhlIGFwcHJvcHJpYXRlIE9GT05PX1ZFTkRPUiBoYW5k
bGluZyBhcyB3ZWxsLjxicj4KCgoKCjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PC9k
aXY+PGRpdj5UaGUgQ0dEQVRBIGRvZXMgbm90IHdvcmsgd2l0aCB0aGUgVGVsaXQgbW9kZW0sIHdo
YXRldmVyIHRoZSB2YWx1ZSBvZiBBVCNDR0FVVEggaXMuIEluIG15IGNhc2UsIEFURCo5OSBpcyBh
YnNvbHV0ZWx5IG5lY2Vzc2FyeS4gVGhlIENHQVVUSCBjb21tYW5kIGlzIGp1c3QgdGhlcmUgdG8g
dXNlIENIQVAgaW5zdGVhZCBvZiBQQVAgYmVjYXVzZSBvZm9ubyBkb2VzbiYjMzk7dCBoYW5kbGUg
aXQuIDxicj4KCgoKPC9kaXY+PGRpdj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFw
eDtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPgpQYXRjaGVzIGFyZSBhbHdheXMgd2VsY29tZS48YnI+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSB0cnlpbmcgdG8gZG8gYSBjbGVhbiBw
YXRjaCBpbiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmMgYnV0IGZvciBzb21lIHJlYXNv
biB0aGUgZmllbGQgZ2NkLSZndDt2ZW5kb3IgaXMgZXF1YWwgdG8gMCBzbyBpdCBkb2VzbiYjMzk7
dCBtYXRjaCB3aXRoIE9GT05PX1ZFTkRPUl9URUxJVC48YnI+CjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlZlbmRv
ciBpcyBzZXQgd2hlbiBjcmVhdGluZyB0aGUgZ3BycyBjb250ZXh0IGluIHRlbGl0X3Bvc3Rfc2lt
KCkgKHBsdWdpbnMvdGVsbGl0LmM6NTYxKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj48
c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmdwcnMgPSBvZm9u
b19ncHJzX2NyZWF0ZShtb2RlbSwgT0ZPTk9fVkVORE9SX1RFTElULCAmcXVvdDthdG1vZGVtJnF1
b3Q7LDwvZGl2Pgo8ZGl2PjxzcGFuIGNsYXNzPSIiIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJ
CQkJPC9zcGFuPmRhdGEtJmd0O2NoYXQpOzwvZGl2PjxkaXY+PHNwYW4gY2xhc3M9IiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5nYyA9IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUo
bW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O21vZGVtKTs8L2Rpdj48L2Rp
dj48ZGl2Pgo8YnI+PC9kaXY+PGRpdj5Zb3UgbmVlZCB0byBjaGFuZ2UgdGhlIHNlY29uZCBhcmd1
bWVudCBmcm9tIDAgdG8gT0ZPTk9fVkVORE9SX1RFTElUPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBw
eCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpy
Z2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
Pgo8ZGl2IGRpcj0ibHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXY+CjwvZGl2PjxkaXY+VGhlIHR3byBBVCBjb21tYW5kcyBhcmUgdGhlIGZv
bGxvd2luZyA6PGJyPjxicj48L2Rpdj48ZGl2Pi8vIGluIGF0X2dwcnNfYWN0aXZhdGVfcHJpbWFy
eSA6PGJyPjwvZGl2PjxkaXY+PGJyPmlmIChnY2QtJmd0O3ZlbmRvciA9PSBPRk9OT19WRU5ET1Jf
VEVMSVQpezxicj6goKAgLyo8YnI+oCCgoCAqIFNldCB0aGUgbW9kZW0gdG8gdXNlIENIQVAgYXV0
aGVudGljYXRpb24gaWYgbmVlZGVkLjxicj4KCqAgoKAgKiBUZWxpdCBtb2RlbXMgdXNlIFBBUCBi
eSBkZWZhdWx0IHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQ8YnI+oCCgoCAqIGJ5IG9mb25vLjxicj6g
IKCgICovPGJyPqAgoKAgZ19hdF9jaGF0X3NlbmQoZ2NkLSZndDtjaGF0LCAmcXVvdDtBVCNHQVVU
SD0yJnF1b3Q7LCBub25lX3ByZWZpeCwgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPn08YnI+PGJyPjxi
cj48YnI+PC9kaXY+PGRpdj4vLyBpbqAgYXRfY2dkY29udF9jYiA6IDxicj4KCjwvZGl2PjxkaXY+
aWYgKGdjZC0mZ3Q7dmVuZG9yID09IE9GT05PX1ZFTkRPUl9URUxJVCl7PGJyPqCgoCAvKjxicj6g
oKCgICogV2l0aCBUZWxpdCBBVCtDR0RBVEEgcHJldmVudHMgdGhlIERDRSBmcm9tIG9mZmVyaW5n
PGJyPqCgoKAgKiBhbiBhdXRoZW50aWNhdGlvbiBwcm90b2NvbCwgc28gd2UgdXNlIHRoaXMgY29t
bWFuZCBpbjxicj6goKCgICogY2FzZSB3ZSBuZWVkIHRvIGNvbm5lY3QgdG8gYSBwcml2YXRlIEFQ
Ti48YnI+CgqgoKCgICovPGJyPjxicj6goKAgc3ByaW50ZihidWYsICZxdW90O0FURCo5OSoqKiV1
IyZxdW90OywgZ2NkLSZndDthY3RpdmVfY29udGV4dCk7PGJyPn08YnI+CjwvZGl2Pgo8L2Rpdj48
L2Rpdj48L2Rpdj4KPGJyPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0Bv
Zm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMu
b2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwczov
L2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPGJyPjwvYmxv
Y2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============4977616568745845572==--

