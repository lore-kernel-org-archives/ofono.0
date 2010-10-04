Content-Type: multipart/mixed; boundary="===============6149829920418569594=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: Query related to UDUB for voice calls.
Date: Mon, 04 Oct 2010 12:28:51 +0530
Message-ID: <AANLkTikyjKjkx_j=ug_yEoC2=W+OpsKG23Dr9PYf5f04@mail.gmail.com>
In-Reply-To: <4CA6670B.90606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6149829920418569594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Denis,

Thanks for the response. I feel like due to the limitation of the AT modem
interface through 27007, we are missing the basic functionality defined in
the other specifications for UDUB.
Please comment.

Thanks,
Sankar.

On Sat, Oct 2, 2010 at 4:26 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Rajesh,
>
> Please, NO top posting on this list.
>
> On 10/01/2010 04:31 PM, Rajesh.Nagaiah(a)elektrobit.com wrote:
> > Hi Sankar,
> >
> > My understanding is that when a call is rejected by the user,
> > irrespective of whether its an incoming call or a waiting call, the
> > cause value for the release call should be set to UDUB, so that for the
> > remote subscriber the User Busy note will be shown in the UI if the
> > voice mailbox is not configured. In the message based modem case, we set
> > the cause value to UDUB with the release call request and in the AT
> > based modem case we should send AT+CHLD=3D0, which will in turn set UDU=
B.
> > So for the Incoming call hangup case if we call vc->driver->hangup(vc,
> > generic_callback, vc); in AT case it will send AT+CHUP which i am not
> > sure is inturn going to set the cause value to UDUB or not (Someone with
> > AT based modem experience can confirm this ???), but for message based
> > modem case its going to call the release call request with cause value
> > Release by user, which will be translated to normal call clearing.
> > So in ofono core the hangup case for Incoming call should be handled in
> > same way as Waiting call by calling vc->driver->set_udub(vc,
> > generic_callback, vc);
> > instead of vc->driver->hangup(vc, generic_callback, vc);, so that UDUB
> > cause is sent to the remote party
> >
>
> Unfortunately AT modems do not allow any CHLD operations on incoming
> calls, including CHLD=3D0.  CHLD=3D0 can only be used to set UDUB on wait=
ing
> calls.  To release incoming calls you must use ATH or +CHUP.  Since AT
> command modems are the only ones described by 3GPP standards, that is
> the modem interface oFono assumes.
>
> If your modem deviates from this standard, then you need to make sure to
> send the proper release cause for incoming calls in the driver for your
> target hardware.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============6149829920418569594==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SEkgRGVuaXMsPGJyPjxicj5UaGFua3MgZm9yIHRoZSByZXNwb25zZS4gSSBmZWVsIGxpa2UgZHVl
IHRvIHRoZSBsaW1pdGF0aW9uIG9mIHRoZSBBVCBtb2RlbSBpbnRlcmZhY2UgdGhyb3VnaCAyNzAw
NywgIHdlIGFyZSBtaXNzaW5nIHRoZSBiYXNpYyBmdW5jdGlvbmFsaXR5IGRlZmluZWQgaW4gdGhl
IG90aGVyIHNwZWNpZmljYXRpb25zIGZvciBVRFVCLjxicj5QbGVhc2UgY29tbWVudC48YnI+Cjxi
cj5UaGFua3MsPGJyPlNhbmthci48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBT
YXQsIE9jdCAyLCAyMDEwIGF0IDQ6MjYgQU0sIERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIi
PiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29t
PC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgbWFyZ2lu
OiAwcHQgMHB0IDBwdCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KSGkgUmFqZXNoLDxicj4K
PGJyPgpQbGVhc2UsIE5PIHRvcCBwb3N0aW5nIG9uIHRoaXMgbGlzdC48YnI+CjxkaXYgY2xhc3M9
ImltIj48YnI+Ck9uIDEwLzAxLzIwMTAgMDQ6MzEgUE0sIDxhIGhyZWY9Im1haWx0bzpSYWplc2gu
TmFnYWlhaEBlbGVrdHJvYml0LmNvbSI+UmFqZXNoLk5hZ2FpYWhAZWxla3Ryb2JpdC5jb208L2E+
IHdyb3RlOjxicj4KJmd0OyBIaSBTYW5rYXIsPGJyPgomZ3Q7PGJyPgomZ3Q7IE15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCB3aGVuIGEgY2FsbCBpcyByZWplY3RlZCBieSB0aGUgdXNlciw8YnI+CiZn
dDsgaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgaXRzIGFuIGluY29taW5nIGNhbGwgb3IgYSB3YWl0
aW5nIGNhbGwsIHRoZTxicj4KJmd0OyBjYXVzZSB2YWx1ZSBmb3IgdGhlIHJlbGVhc2UgY2FsbCBz
aG91bGQgYmUgc2V0IHRvIFVEVUIsIHNvIHRoYXQgZm9yIHRoZTxicj4KJmd0OyByZW1vdGUgc3Vi
c2NyaWJlciB0aGUgVXNlciBCdXN5IG5vdGUgd2lsbCBiZSBzaG93biBpbiB0aGUgVUkgaWYgdGhl
PGJyPgomZ3Q7IHZvaWNlIG1haWxib3ggaXMgbm90IGNvbmZpZ3VyZWQuIEluIHRoZSBtZXNzYWdl
IGJhc2VkIG1vZGVtIGNhc2UsIHdlIHNldDxicj4KJmd0OyB0aGUgY2F1c2UgdmFsdWUgdG8gVURV
QiB3aXRoIHRoZSByZWxlYXNlIGNhbGwgcmVxdWVzdCBhbmQgaW4gdGhlIEFUPGJyPgomZ3Q7IGJh
c2VkIG1vZGVtIGNhc2Ugd2Ugc2hvdWxkIHNlbmQgQVQrQ0hMRD0wLCB3aGljaCB3aWxsIGluIHR1
cm4gc2V0IFVEVUIuPGJyPgomZ3Q7IFNvIGZvciB0aGUgSW5jb21pbmcgY2FsbCBoYW5ndXAgY2Fz
ZSBpZiB3ZSBjYWxsIHZjLSZndDtkcml2ZXItJmd0O2hhbmd1cCh2Yyw8YnI+CiZndDsgZ2VuZXJp
Y19jYWxsYmFjaywgdmMpOyBpbiBBVCBjYXNlIGl0IHdpbGwgc2VuZCBBVCtDSFVQIHdoaWNoIGkg
YW0gbm90PGJyPgomZ3Q7IHN1cmUgaXMgaW50dXJuIGdvaW5nIHRvIHNldCB0aGUgY2F1c2UgdmFs
dWUgdG8gVURVQiBvciBub3QgKFNvbWVvbmUgd2l0aDxicj4KJmd0OyBBVCBiYXNlZCBtb2RlbSBl
eHBlcmllbmNlIGNhbiBjb25maXJtIHRoaXMgPz8/KSwgYnV0IGZvciBtZXNzYWdlIGJhc2VkPGJy
PgomZ3Q7IG1vZGVtIGNhc2UgaXRzIGdvaW5nIHRvIGNhbGwgdGhlIHJlbGVhc2UgY2FsbCByZXF1
ZXN0IHdpdGggY2F1c2UgdmFsdWU8YnI+CiZndDsgUmVsZWFzZSBieSB1c2VyLCB3aGljaCB3aWxs
IGJlIHRyYW5zbGF0ZWQgdG8gbm9ybWFsIGNhbGwgY2xlYXJpbmcuPGJyPgomZ3Q7IFNvIGluIG9m
b25vIGNvcmUgdGhlIGhhbmd1cCBjYXNlIGZvciBJbmNvbWluZyBjYWxsIHNob3VsZCBiZSBoYW5k
bGVkIGluPGJyPgomZ3Q7IHNhbWUgd2F5IGFzIFdhaXRpbmcgY2FsbCBieSBjYWxsaW5nIHZjLSZn
dDtkcml2ZXItJmd0O3NldF91ZHViKHZjLDxicj4KJmd0OyBnZW5lcmljX2NhbGxiYWNrLCB2Yyk7
PGJyPgomZ3Q7IGluc3RlYWQgb2YgdmMtJmd0O2RyaXZlci0mZ3Q7aGFuZ3VwKHZjLCBnZW5lcmlj
X2NhbGxiYWNrLCB2Yyk7LCBzbyB0aGF0IFVEVUI8YnI+CiZndDsgY2F1c2UgaXMgc2VudCB0byB0
aGUgcmVtb3RlIHBhcnR5PGJyPgomZ3Q7PGJyPgo8YnI+CjwvZGl2PlVuZm9ydHVuYXRlbHkgQVQg
bW9kZW1zIGRvIG5vdCBhbGxvdyBhbnkgQ0hMRCBvcGVyYXRpb25zIG9uIGluY29taW5nPGJyPgpj
YWxscywgaW5jbHVkaW5nIENITEQ9MC4goENITEQ9MCBjYW4gb25seSBiZSB1c2VkIHRvIHNldCBV
RFVCIG9uIHdhaXRpbmc8YnI+CmNhbGxzLiCgVG8gcmVsZWFzZSBpbmNvbWluZyBjYWxscyB5b3Ug
bXVzdCB1c2UgQVRIIG9yICtDSFVQLiCgU2luY2UgQVQ8YnI+CmNvbW1hbmQgbW9kZW1zIGFyZSB0
aGUgb25seSBvbmVzIGRlc2NyaWJlZCBieSAzR1BQIHN0YW5kYXJkcywgdGhhdCBpczxicj4KdGhl
IG1vZGVtIGludGVyZmFjZSBvRm9ubyBhc3N1bWVzLjxicj4KPGJyPgpJZiB5b3VyIG1vZGVtIGRl
dmlhdGVzIGZyb20gdGhpcyBzdGFuZGFyZCwgdGhlbiB5b3UgbmVlZCB0byBtYWtlIHN1cmUgdG88
YnI+CnNlbmQgdGhlIHByb3BlciByZWxlYXNlIGNhdXNlIGZvciBpbmNvbWluZyBjYWxscyBpbiB0
aGUgZHJpdmVyIGZvciB5b3VyPGJyPgp0YXJnZXQgaGFyZHdhcmUuPGJyPgo8YnI+ClJlZ2FyZHMs
PGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LURlbmlzPGJyPgo8L2ZvbnQ+PGRpdj48ZGl2Pjwv
ZGl2PjxkaXYgY2xhc3M9Img1Ij5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zv
bm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlz
dHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3Rz
Lm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZGl2PjwvZGl2PjwvYmxvY2txdW90
ZT48L2Rpdj48YnI+Cg==

--===============6149829920418569594==--

