Content-Type: multipart/mixed; boundary="===============1871134344971666353=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Mon, 12 Aug 2013 11:19:15 +0200
Message-ID: <CAMtf1D_xxJtSppKribWFBi01beAsXowm5_jAp6+gqTtdjTMLGg@mail.gmail.com>
In-Reply-To: <5204FBA4.6040809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1871134344971666353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2013/8/9 Denis Kenzior <denkenz@gmail.com>

>


>> Another topic is the authentication protocol. By default the Telit HE910
>> uses PAP which is not handled by ofono.
>> I started to implement it in gatchat/ppp_auth.c it is not quite perfect
>> because it does not ask to do CHAP before falling back to PAP but if
>> anyone
>> is interested i would be glad to share the code.
>> We then found out that there is a custom AT command for the Telit HE910
>> that
>> allows you to set the authentication protocol to use : AT#CGAUTH=3D[0,1,=
 or
>> 2]
>> I added it in plugins/telit.c in the post_online function and stopped
>> working on PAP. (I am using the telit rework patch provided by Jonas Bonn
>> on
>> the 4th of April)
>>
>
> Does this work with CGDATA?  If that is the case it might explain why
> CGDATA does not ask for authentication.  You can enable this command insi=
de
> drivers/atmodem/gprs-context.c with the appropriate OFONO_VENDOR handling
> as well.
>
>
The CGDATA does not work with the Telit modem, whatever the value of
AT#CGAUTH is. In my case, ATD*99 is absolutely necessary. The CGAUTH
command is just there to use CHAP instead of PAP because ofono doesn't
handle it.


> Patches are always welcome.
>

I am trying to do a clean patch in drivers/atmodem/gprs-context.c but for
some reason the field gcd->vendor is equal to 0 so it doesn't match with
OFONO_VENDOR_TELIT.
The two AT commands are the following :

// in at_gprs_activate_primary :

if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT){
    /*
     * Set the modem to use CHAP authentication if needed.
     * Telit modems use PAP by default which is not supported
     * by ofono.
     */
     g_at_chat_send(gcd->chat, "AT#GAUTH=3D2", none_prefix, NULL, NULL, NUL=
L);
}



// in  at_cgdcont_cb :
if (gcd->vendor =3D=3D OFONO_VENDOR_TELIT){
    /*
     * With Telit AT+CGDATA prevents the DCE from offering
     * an authentication protocol, so we use this command in
     * case we need to connect to a private APN.
     */

    sprintf(buf, "ATD*99***%u#", gcd->active_context);
}

--===============1871134344971666353==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj4yMDEzLzgvOSBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFp
bC5jb208L2E+Jmd0Ozwvc3Bhbj48YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgoKCgoKoDwvYmxvY2txdW90ZT48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KPGJyPgpBbm90aGVyIHRvcGljIGlzIHRoZSBhdXRoZW50aWNhdGlvbiBwcm90b2Nv
bC4gQnkgZGVmYXVsdCB0aGUgVGVsaXQgSEU5MTA8YnI+CnVzZXMgUEFQIHdoaWNoIGlzIG5vdCBo
YW5kbGVkIGJ5IG9mb25vLjxicj4KSSBzdGFydGVkIHRvIGltcGxlbWVudCBpdCBpbiBnYXRjaGF0
L3BwcF9hdXRoLmMgaXQgaXMgbm90IHF1aXRlIHBlcmZlY3Q8YnI+CmJlY2F1c2UgaXQgZG9lcyBu
b3QgYXNrIHRvIGRvIENIQVAgYmVmb3JlIGZhbGxpbmcgYmFjayB0byBQQVAgYnV0IGlmIGFueW9u
ZTxicj4KaXMgaW50ZXJlc3RlZCBpIHdvdWxkIGJlIGdsYWQgdG8gc2hhcmUgdGhlIGNvZGUuPGJy
PgpXZSB0aGVuIGZvdW5kIG91dCB0aGF0IHRoZXJlIGlzIGEgY3VzdG9tIEFUIGNvbW1hbmQgZm9y
IHRoZSBUZWxpdCBIRTkxMCB0aGF0PGJyPgphbGxvd3MgeW91IHRvIHNldCB0aGUgYXV0aGVudGlj
YXRpb24gcHJvdG9jb2wgdG8gdXNlIDogQVQjQ0dBVVRIPVswLDEsIG9yIDJdPGJyPgpJIGFkZGVk
IGl0IGluIHBsdWdpbnMvdGVsaXQuYyBpbiB0aGUgcG9zdF9vbmxpbmUgZnVuY3Rpb24gYW5kIHN0
b3BwZWQ8YnI+Cndvcmtpbmcgb24gUEFQLiAoSSBhbSB1c2luZyB0aGUgdGVsaXQgcmV3b3JrIHBh
dGNoIHByb3ZpZGVkIGJ5IEpvbmFzIEJvbm4gb248YnI+CnRoZSA0dGggb2YgQXByaWwpPGJyPgo8
L2Jsb2NrcXVvdGU+Cjxicj4KRG9lcyB0aGlzIHdvcmsgd2l0aCBDR0RBVEE/IKBJZiB0aGF0IGlz
IHRoZSBjYXNlIGl0IG1pZ2h0IGV4cGxhaW4gd2h5IENHREFUQSBkb2VzIG5vdCBhc2sgZm9yIGF1
dGhlbnRpY2F0aW9uLiCgWW91IGNhbiBlbmFibGUgdGhpcyBjb21tYW5kIGluc2lkZSBkcml2ZXJz
L2F0bW9kZW0vZ3Bycy1jb250ZXh0LmMgd2l0aCB0aGUgYXBwcm9wcmlhdGUgT0ZPTk9fVkVORE9S
IGhhbmRsaW5nIGFzIHdlbGwuPGJyPgoKCgo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+VGhlIENHREFUQSBkb2VzIG5vdCB3b3JrIHdpdGggdGhlIFRlbGl0IG1vZGVtLCB3aGF0
ZXZlciB0aGUgdmFsdWUgb2YgQVQjQ0dBVVRIIGlzLiBJbiBteSBjYXNlLCBBVEQqOTkgaXMgYWJz
b2x1dGVseSBuZWNlc3NhcnkuIFRoZSBDR0FVVEggY29tbWFuZCBpcyBqdXN0IHRoZXJlIHRvIHVz
ZSBDSEFQIGluc3RlYWQgb2YgUEFQIGJlY2F1c2Ugb2Zvbm8gZG9lc24mIzM5O3QgaGFuZGxlIGl0
LiA8YnI+CgoKPC9kaXY+PGRpdj6gPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpQYXRjaGVzIGFyZSBhbHdheXMgd2Vs
Y29tZS48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSB0cnlpbmcgdG8g
ZG8gYSBjbGVhbiBwYXRjaCBpbiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmMgYnV0IGZv
ciBzb21lIHJlYXNvbiB0aGUgZmllbGQgZ2NkLSZndDt2ZW5kb3IgaXMgZXF1YWwgdG8gMCBzbyBp
dCBkb2VzbiYjMzk7dCBtYXRjaCB3aXRoIE9GT05PX1ZFTkRPUl9URUxJVC48YnI+CjwvZGl2Pjxk
aXY+VGhlIHR3byBBVCBjb21tYW5kcyBhcmUgdGhlIGZvbGxvd2luZyA6PGJyPjxicj48L2Rpdj48
ZGl2Pi8vIGluIGF0X2dwcnNfYWN0aXZhdGVfcHJpbWFyeSA6PGJyPjwvZGl2PjxkaXY+PGJyPmlm
IChnY2QtJmd0O3ZlbmRvciA9PSBPRk9OT19WRU5ET1JfVEVMSVQpezxicj6goKAgLyo8YnI+oCCg
oCAqIFNldCB0aGUgbW9kZW0gdG8gdXNlIENIQVAgYXV0aGVudGljYXRpb24gaWYgbmVlZGVkLjxi
cj4KoCCgoCAqIFRlbGl0IG1vZGVtcyB1c2UgUEFQIGJ5IGRlZmF1bHQgd2hpY2ggaXMgbm90IHN1
cHBvcnRlZDxicj6gIKCgICogYnkgb2Zvbm8uPGJyPqAgoKAgKi88YnI+oCCgoCBnX2F0X2NoYXRf
c2VuZChnY2QtJmd0O2NoYXQsICZxdW90O0FUI0dBVVRIPTImcXVvdDssIG5vbmVfcHJlZml4LCBO
VUxMLCBOVUxMLCBOVUxMKTs8YnI+fTxicj48YnI+PGJyPjxicj48L2Rpdj48ZGl2Pi8vIGluoCBh
dF9jZ2Rjb250X2NiIDogPGJyPgo8L2Rpdj48ZGl2PmlmIChnY2QtJmd0O3ZlbmRvciA9PSBPRk9O
T19WRU5ET1JfVEVMSVQpezxicj6goKAgLyo8YnI+oKCgoCAqIFdpdGggVGVsaXQgQVQrQ0dEQVRB
IHByZXZlbnRzIHRoZSBEQ0UgZnJvbSBvZmZlcmluZzxicj6goKCgICogYW4gYXV0aGVudGljYXRp
b24gcHJvdG9jb2wsIHNvIHdlIHVzZSB0aGlzIGNvbW1hbmQgaW48YnI+oKCgoCAqIGNhc2Ugd2Ug
bmVlZCB0byBjb25uZWN0IHRvIGEgcHJpdmF0ZSBBUE4uPGJyPgqgoKCgICovPGJyPjxicj6goKAg
c3ByaW50ZihidWYsICZxdW90O0FURCo5OSoqKiV1IyZxdW90OywgZ2NkLSZndDthY3RpdmVfY29u
dGV4dCk7PGJyPn08YnI+CjwvZGl2Pgo8L2Rpdj48L2Rpdj48L2Rpdj4K

--===============1871134344971666353==--

