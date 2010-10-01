Content-Type: multipart/mixed; boundary="===============0523720619457185901=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Query related to UDUB for voice calls.
Date: Fri, 01 Oct 2010 15:03:27 +0530
Message-ID: <AANLkTim_eSE2qwKUzbfNYhmxu73As=pDvyriVhqWWaXa@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0523720619457185901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was referring to the voice calls portion of ofono and I have a query
related to user determined user busy.

In the ofono core, if the user rejects a voice call, based on the call
status, respective driver function is called. I have pasted the code below.

static DBusMessage *voicecall_hangup(
DBusConnection *conn,
                    DBusMessage *msg, void *data)
{
            /* According to various specs, other than 27.007, +CHUP is used
     * to reject an incoming call
     */
    if (call->status =3D=3D CALL_STATUS_INCOMING) {
        if (vc->driver->hangup =3D=3D NULL)
            return __ofono_error_not_implemented(msg);

        vc->pending =3D dbus_message_ref(msg);
        vc->driver->hangup(vc, generic_callback, vc);

        return NULL;
    }

    if (call->status =3D=3D CALL_STATUS_WAITING) {
        if (vc->driver->set_udub =3D=3D NULL)
            return __ofono_error_not_implemented(msg);

        vc->pending =3D dbus_message_ref(msg);
        vc->driver->set_udub(vc, generic_callback, vc);

        return NULL;
    }

}

But as per the 3GPP TS 22001 v6.0.0, UDUB applies to an incoming call also.
Below is the excerpt from the specification.

C.3

User Determined User Busy (UDUB) condition
This condition occurs when a call is offered to a user equipment and the UE
responds "user busy" because the
subscribers resources (terminal or person using them) are busy. Then the
PLMN will clear the call with the indication
"busy" back towards the calling subscriber (see also clause 4).

Can some please clarify if the above behaviour in ofono core is proper or
this need to be corrected?

Thanks,
Sankar.

--===============0523720619457185901==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5JIHdhcyByZWZlcnJpbmcgdG8gdGhlIHZvaWNlIGNhbGxzIHBvcnRpb24gb2Yg
b2Zvbm8gYW5kIEkgaGF2ZSBhIHF1ZXJ5IHJlbGF0ZWQgdG8gdXNlciBkZXRlcm1pbmVkIHVzZXIg
YnVzeS4gPGJyPjxicj5Jbgp0aGUgb2Zvbm8gY29yZSwgaWYgdGhlIHVzZXIgcmVqZWN0cyBhIHZv
aWNlIGNhbGwsIGJhc2VkIG9uIHRoZSBjYWxsCnN0YXR1cywgcmVzcGVjdGl2ZSBkcml2ZXIgZnVu
Y3Rpb24gaXMgY2FsbGVkLiBJIGhhdmUgcGFzdGVkIHRoZSBjb2RlCmJlbG93Ljxicj4KPGJyPnN0
YXRpYyBEQnVzTWVzc2FnZSAqdm9pY2VjYWxsX2hhbmd1cCg8ZGl2PkRCdXNDb25uZWN0aW9uICpj
b25uLDxicj6goKAgoKCgIKCgoCCgoKAgoKCgIERCdXNNZXNzYWdlICptc2csIHZvaWQgKmRhdGEp
PGJyPns8YnI+oKCgoKCgoCCgoKAgLyogQWNjb3JkaW5nIHRvIHZhcmlvdXMgc3BlY3MsIG90aGVy
IHRoYW4gMjcuMDA3LCArQ0hVUCBpcyB1c2VkPGJyPgqgoKAgoCogdG8gcmVqZWN0IGFuIGluY29t
aW5nIGNhbGw8YnI+oKCgIKAqLzxicj6goKAgaWYgKGNhbGwtJmd0O3N0YXR1cyA9PSBDQUxMX1NU
QVRVU19JTkNPTUlORykgezxicj6goKAgoKCgIGlmICh2Yy0mZ3Q7ZHJpdmVyLSZndDtoYW5ndXAg
PT0gTlVMTCk8YnI+oKCgIKCgoCCgoKAgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2ltcGxlbWVu
dGVkKG1zZyk7PGJyPjxicj6goKAgoKCgIHZjLSZndDtwZW5kaW5nID0gZGJ1c19tZXNzYWdlX3Jl
Zihtc2cpOzxicj4KCgqgoKAgoKCgIHZjLSZndDtkcml2ZXItJmd0O2hhbmd1cCh2YywgZ2VuZXJp
Y19jYWxsYmFjaywgdmMpOzxicj48YnI+oKCgIKCgoCByZXR1cm4gTlVMTDs8YnI+oKCgIH08YnI+
PGJyPqCgoCBpZiAoY2FsbC0mZ3Q7c3RhdHVzID09IENBTExfU1RBVFVTX1dBSVRJTkcpIHs8YnI+
oKCgIKCgoCBpZiAodmMtJmd0O2RyaXZlci0mZ3Q7c2V0X3VkdWIgPT0gTlVMTCk8YnI+oKCgIKCg
oCCgoKAgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2ltcGxlbWVudGVkKG1zZyk7PGJyPgoKCjxi
cj6goKAgoKCgIHZjLSZndDtwZW5kaW5nID0gZGJ1c19tZXNzYWdlX3JlZihtc2cpOzxicj6goKAg
oKCgIHZjLSZndDtkcml2ZXItJmd0O3NldF91ZHViKHZjLCBnZW5lcmljX2NhbGxiYWNrLCB2Yyk7
PGJyPjxicj6goKAgoKCgIHJldHVybiBOVUxMOzxicj6goKAgfTxicj48YnI+fTxicj48YnI+QnV0
IGFzIHBlciB0aGUgM0dQUCBUUyAyMjAwMSB2Ni4wLjAsIFVEVUIgYXBwbGllcyB0byBhbiBpbmNv
bWluZyBjYWxsIGFsc28uIEJlbG93IGlzIHRoZSBleGNlcnB0IGZyb20gdGhlIHNwZWNpZmljYXRp
b24uPGJyPgoKPGJyPkMuMzxkaXY+PGJyPlVzZXIgRGV0ZXJtaW5lZCBVc2VyIEJ1c3kgKFVEVUIp
IGNvbmRpdGlvbjxicj48L2Rpdj5UaGlzIGNvbmRpdGlvbiBvY2N1cnMgd2hlbiBhIGNhbGwgaXMg
b2ZmZXJlZCB0byBhIHVzZXIgZXF1aXBtZW50IGFuZCB0aGUgVUUgcmVzcG9uZHMgJnF1b3Q7dXNl
ciBidXN5JnF1b3Q7IGJlY2F1c2UgdGhlPGJyPgpzdWJzY3JpYmVycyByZXNvdXJjZXMgKHRlcm1p
bmFsIG9yIHBlcnNvbiB1c2luZyB0aGVtKSBhcmUgYnVzeS4gVGhlbiB0aGUgUExNTiB3aWxsIGNs
ZWFyIHRoZSBjYWxsIHdpdGggdGhlIGluZGljYXRpb248YnI+JnF1b3Q7YnVzeSZxdW90OyBiYWNr
IHRvd2FyZHMgdGhlIGNhbGxpbmcgc3Vic2NyaWJlciAoc2VlIGFsc28gY2xhdXNlIDQpLjwvZGl2
Pjxicj5DYW4gc29tZSBwbGVhc2UgY2xhcmlmeSBpZiB0aGUgYWJvdmUgYmVoYXZpb3VyIGluIG9m
b25vIGNvcmUgaXMgcHJvcGVyIG9yIHRoaXMgbmVlZCB0byBiZSBjb3JyZWN0ZWQ/PGJyPgoKPGJy
PlRoYW5rcyw8YnI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPlNhbmthci48L2ZvbnQ+Cg==

--===============0523720619457185901==--

