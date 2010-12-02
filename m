Content-Type: multipart/mixed; boundary="===============4505651132913558633=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Re: Need Clarification on DCS handling in Status Report for SMS
Date: Thu, 02 Dec 2010 10:58:36 +0530
Message-ID: <AANLkTikY7JxydmBXV8yC5Ghg-0Q725pZ7hNRBUZzBQbU@mail.gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3A7C0@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4505651132913558633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,


On Thu, Dec 2, 2010 at 7:33 AM, <Rajesh.Nagaiah@elektrobit.com> wrote:

> Hi Sankar,
>
> > In the decode SMS function, there is a check to find out if
> > there is a PI (parameter identifier). If there is a PI and no
> > DCS flag set, then the ofono core sets the dcs to default. If
> > the PI itself is missing in the PDU received from the
> > network, then the dcs values are not set to default.
> >
> > This seems to cause a problem, where, the decoding of dcs
> > fails, and results in not sending the delivery notification
> > to clients.
>
> Yes, this is a bug. But rather than setting the DCS to default in
> this case, we should rather not call that sms_dcs_decode() function
> from ofono_sms_status_notify(), as the class information derived from
> the DCS decoding is not used there and also we are not handling the
> optional text information in the status report handling currently.
>
> If we decide to handle this optional text information (most likely not
> going to happen), then some modifications are required.
>
> Also there is another bug in the current code which might not be
> relevant
> if we decide to remove the sms_dcs_decode() function call from
> ofono_sms_status_notify(). In that function call instead of passing
> s.status_report.dcs, we are currently passing s.deliver.dcs.
>

Thanks for your inputs. Can you please let me know when this will be
addressed in the ofono.

>
> BR,
> Rajesh
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============4505651132913558633==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgUmFqZXNoLDxicj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBUaHUsIERl
YyAyLCAyMDEwIGF0IDc6MzMgQU0sICA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0
bzpSYWplc2guTmFnYWlhaEBlbGVrdHJvYml0LmNvbSI+UmFqZXNoLk5hZ2FpYWhAZWxla3Ryb2Jp
dC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBt
YXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgpIaSBTYW5rYXIs
PGJyPgo8ZGl2IGNsYXNzPSJpbSI+PGJyPgomZ3Q7IEluIHRoZSBkZWNvZGUgU01TIGZ1bmN0aW9u
LCB0aGVyZSBpcyBhIGNoZWNrIHRvIGZpbmQgb3V0IGlmPGJyPgomZ3Q7IHRoZXJlIGlzIGEgUEkg
KHBhcmFtZXRlciBpZGVudGlmaWVyKS4gSWYgdGhlcmUgaXMgYSBQSSBhbmQgbm88YnI+CiZndDsg
RENTIGZsYWcgc2V0LCB0aGVuIHRoZSBvZm9ubyBjb3JlIHNldHMgdGhlIGRjcyB0byBkZWZhdWx0
LiBJZjxicj4KJmd0OyB0aGUgUEkgaXRzZWxmIGlzIG1pc3NpbmcgaW4gdGhlIFBEVSByZWNlaXZl
ZCBmcm9tIHRoZTxicj4KJmd0OyBuZXR3b3JrLCB0aGVuIHRoZSBkY3MgdmFsdWVzIGFyZSBub3Qg
c2V0IHRvIGRlZmF1bHQuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRoaXMgc2VlbXMgdG8gY2F1c2UgYSBw
cm9ibGVtLCB3aGVyZSwgdGhlIGRlY29kaW5nIG9mIGRjczxicj4KJmd0OyBmYWlscywgYW5kIHJl
c3VsdHMgaW4gbm90IHNlbmRpbmcgdGhlIGRlbGl2ZXJ5IG5vdGlmaWNhdGlvbjxicj4KJmd0OyB0
byBjbGllbnRzLjxicj4KPGJyPgo8L2Rpdj5ZZXMsIHRoaXMgaXMgYSBidWcuIEJ1dCByYXRoZXIg
dGhhbiBzZXR0aW5nIHRoZSBEQ1MgdG8gZGVmYXVsdCBpbjxicj4KdGhpcyBjYXNlLCB3ZSBzaG91
bGQgcmF0aGVyIG5vdCBjYWxsIHRoYXQgc21zX2Rjc19kZWNvZGUoKSBmdW5jdGlvbjxicj4KZnJv
bSBvZm9ub19zbXNfc3RhdHVzX25vdGlmeSgpLCBhcyB0aGUgY2xhc3MgaW5mb3JtYXRpb24gZGVy
aXZlZCBmcm9tPGJyPgp0aGUgRENTIGRlY29kaW5nIGlzIG5vdCB1c2VkIHRoZXJlIGFuZCBhbHNv
IHdlIGFyZSBub3QgaGFuZGxpbmcgdGhlPGJyPgpvcHRpb25hbCB0ZXh0IGluZm9ybWF0aW9uIGlu
IHRoZSBzdGF0dXMgcmVwb3J0IGhhbmRsaW5nIGN1cnJlbnRseS48YnI+Cjxicj4KSWYgd2UgZGVj
aWRlIHRvIGhhbmRsZSB0aGlzIG9wdGlvbmFsIHRleHQgaW5mb3JtYXRpb24gKG1vc3QgbGlrZWx5
IG5vdDxicj4KZ29pbmcgdG8gaGFwcGVuKSwgdGhlbiBzb21lIG1vZGlmaWNhdGlvbnMgYXJlIHJl
cXVpcmVkLjxicj4KPGJyPgpBbHNvIHRoZXJlIGlzIGFub3RoZXIgYnVnIGluIHRoZSBjdXJyZW50
IGNvZGUgd2hpY2ggbWlnaHQgbm90IGJlPGJyPgpyZWxldmFudDxicj4KaWYgd2UgZGVjaWRlIHRv
IHJlbW92ZSB0aGUgc21zX2Rjc19kZWNvZGUoKSBmdW5jdGlvbiBjYWxsIGZyb208YnI+Cm9mb25v
X3Ntc19zdGF0dXNfbm90aWZ5KCkuIEluIHRoYXQgZnVuY3Rpb24gY2FsbCBpbnN0ZWFkIG9mIHBh
c3Npbmc8YnI+CnMuc3RhdHVzX3JlcG9ydC5kY3MsIHdlIGFyZSBjdXJyZW50bHkgcGFzc2luZyBz
LmRlbGl2ZXIuZGNzLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+VGhhbmtzIGZvciB5b3VyIGlu
cHV0cy4gQ2FuIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgd2hlbiB0aGlzIHdpbGwgYmUgYWRkcmVz
c2VkIGluIHRoZSBvZm9uby4gPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBtYXJn
aW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFleDsiPgoKPGJyPgpCUiw8YnI+
ClJhamVzaDxicj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25v
Lm9yZyI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25v
Lm9yZy9saXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5vZm9uby5v
cmcvbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============4505651132913558633==--

