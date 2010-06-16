Content-Type: multipart/mixed; boundary="===============4186719885271177806=="
MIME-Version: 1.0
From: Arun Ravindran <arunlee@gmail.com>
Subject: ATModem-PPP Doubts
Date: Wed, 16 Jun 2010 06:19:30 +0300
Message-ID: <AANLkTikuv3eSYcZa-7SjeJStY9fn04np95rxTYnlLjw3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4186719885271177806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

We using a modem through atmodem interface. While testing the
functionalities, we found that the dataconnectionmanager interface is not
coming up.

We enabled the gprs modem driver creation and context creation in by adding
it in atgen.c

atgen_post_sim(struct ofono_modem *modem)
{
---------------------------------------------------------------
---------------------------------------------------------------
gprs =3D ofono_gprs_create(modem,0, "atmodem", chat);
gc =3D ofono_gprs_context_create(modem, 0, "atmodem", chat);

if (gprs && gc)
        ofono_gprs_add_context(gprs, gc);

mw =3D ofono_message_waiting_create(modem);
if (mw)
        ofono_message_waiting_register(mw);

}
After this change the dataconnection manager interface was shown in the
./list-medem script.

1) Is this a correct change ? why was this not present in atgen? Could any
one clarify?


We wanted PDP context activation through atmodem and we could see that our
modem returns
*at+cgdcont=3D?
+CGDCONT: (1-255),("IP","IPV6"),,,(0),(0,1,2)

OK
*
where as Nokia modem (E63) returns

*at+cgdcont=3D?
+CGDCONT: (1-2),"IP",,,(0),(0)
+CGDCONT: (1-2),"IPV6",,,(0),(0)

OK
*
The modem we use is returning the string in a different way from 3GPP 27.007
, which says to return the multiple PDP types are separate lines.

We modified the Gprs.c file in atmodem driver, to search for the list of
strings, and we are able to make PDP context activation.

2) Is this change an accepted one?

3) Currently i am stuck at the PPP (IPCP stage), how can i link this context
(and PPP link) to my Ubuntu's network manager?

Regards
Arun

--===============4186719885271177806==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPkhpLDxicj48YnI+V2UgdXNpbmcgYSBtb2RlbSB0aHJv
dWdoIGF0bW9kZW0gaW50ZXJmYWNlLiBXaGlsZSB0ZXN0aW5nIHRoZSBmdW5jdGlvbmFsaXRpZXMs
IHdlIGZvdW5kIHRoYXQgdGhlIGRhdGFjb25uZWN0aW9ubWFuYWdlciBpbnRlcmZhY2UgaXMgbm90
IGNvbWluZyB1cC48YnI+PGJyPldlIGVuYWJsZWQgdGhlIGdwcnMgbW9kZW0gZHJpdmVyIGNyZWF0
aW9uIGFuZCBjb250ZXh0IGNyZWF0aW9uIGluIGJ5IGFkZGluZyBpdCBpbiBhdGdlbi5jPGJyPgo8
YnI+YXRnZW5fcG9zdF9zaW0oc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+ezxicj4tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS08YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPGJyPmdwcnMgPSBvZm9ub19ncHJzX2NyZWF0ZShtb2RlbSwwLCAmcXVvdDth
dG1vZGVtJnF1b3Q7LCBjaGF0KTs8YnI+CiBnYyA9IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUo
bW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGNoYXQpOzxicj48YnI+aWYgKGdwcnMgJmFt
cDsmYW1wOyBnYyk8YnI+oKCgIKCgoCBvZm9ub19ncHJzX2FkZF9jb250ZXh0KGdwcnMsIGdjKTs8
YnI+PGJyPm13ID0gb2Zvbm9fbWVzc2FnZV93YWl0aW5nX2NyZWF0ZShtb2RlbSk7PGJyPmlmICht
dyk8YnI+oKCgIKCgoCBvZm9ub19tZXNzYWdlX3dhaXRpbmdfcmVnaXN0ZXIobXcpOzxicj4KPGJy
Pn08YnI+QWZ0ZXIgdGhpcyBjaGFuZ2UgdGhlIGRhdGFjb25uZWN0aW9uIG1hbmFnZXIgaW50ZXJm
YWNlIHdhcyBzaG93biBpbiB0aGUgLi9saXN0LW1lZGVtIHNjcmlwdC48YnI+PGJyPjEpIElzIHRo
aXMgYSBjb3JyZWN0IGNoYW5nZSA/IHdoeSB3YXMgdGhpcyBub3QgcHJlc2VudCBpbiBhdGdlbj8g
Q291bGQgYW55IG9uZSBjbGFyaWZ5Pzxicj48YnI+PGJyPldlIHdhbnRlZCBQRFAgY29udGV4dCBh
Y3RpdmF0aW9uIHRocm91Z2ggYXRtb2RlbSBhbmQgd2UgY291bGQgc2VlIHRoYXQgb3VyIG1vZGVt
IHJldHVybnM8YnI+CjxiPmF0K2NnZGNvbnQ9Pzxicj4rQ0dEQ09OVDogKDEtMjU1KSwoJnF1b3Q7
SVAmcXVvdDssJnF1b3Q7SVBWNiZxdW90OyksLCwoMCksKDAsMSwyKTxicj4KCjxicj5PSzxicj48
L2I+PGJyPndoZXJlIGFzIE5va2lhIG1vZGVtIChFNjMpIHJldHVybnM8YnI+PGJyPjxiPmF0K2Nn
ZGNvbnQ9Pzxicj4rQ0dEQ09OVDogKDEtMiksJnF1b3Q7SVAmcXVvdDssLCwoMCksKDApPGJyPitD
R0RDT05UOiAoMS0yKSwmcXVvdDtJUFY2JnF1b3Q7LCwsKDApLCgwKTxicj48YnI+T0s8YnI+PC9i
Pjxicj5UaGUgbW9kZW0gd2UgdXNlIGlzIHJldHVybmluZyB0aGUgc3RyaW5nIGluIGEgZGlmZmVy
ZW50IHdheSBmcm9tIDNHUFAgMjcuMDA3ICwgd2hpY2ggc2F5cyB0byByZXR1cm4gdGhlIG11bHRp
cGxlIFBEUCB0eXBlcyBhcmUgc2VwYXJhdGUgbGluZXMuPGJyPgo8YnI+CgoKV2UgbW9kaWZpZWQg
dGhlIEdwcnMuYyBmaWxlIGluIGF0bW9kZW0gZHJpdmVyLCB0byBzZWFyY2ggZm9yIHRoZSBsaXN0
IG9mIHN0cmluZ3MsIGFuZCB3ZSBhcmUgYWJsZSB0byBtYWtlIFBEUCBjb250ZXh0IGFjdGl2YXRp
b24uPGJyPjxicj4yKSBJcyB0aGlzIGNoYW5nZSBhbiBhY2NlcHRlZCBvbmU/IDxicj48YnI+IDMp
IEN1cnJlbnRseSBpIGFtIHN0dWNrIGF0IHRoZSBQUFAgKElQQ1Agc3RhZ2UpLCBob3cgY2FuIGkg
bGluayB0aGlzIGNvbnRleHQgKGFuZCBQUFAgbGluaykgdG8gbXkgVWJ1bnR1JiMzOTtzIG5ldHdv
cmsgbWFuYWdlcj88YnI+Cjxicj5SZWdhcmRzPGJyPjxmb250IGNvbG9yPSIjODg4ODg4Ij5BcnVu
PGJyPjxicj48YnI+CjwvZm9udD48L2Rpdj48YnI+Cg==

--===============4186719885271177806==--

