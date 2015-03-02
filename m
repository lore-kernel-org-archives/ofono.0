Content-Type: multipart/mixed; boundary="===============7713865786870152250=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: Receiving raw SMS through Ofono "incoming-message" callback
Date: Mon, 02 Mar 2015 13:45:32 +0200
Message-ID: <CAEM=xjhdg0CV2FqurNzmrqSAaWjr4ui=na+tqmTtvGrDa8Q2Eg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7713865786870152250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like the SMS receive API attempts to represent the incoming SMS as
an array of characters inside the callback function.

IncomingMessage(string message, dict info)

I am expecting a raw payload of server data via SMS. I cannot see how this
will work in the current implementation since the raw data may well be full
of zeros which will act as a string terminator.

Any ideas?

Kind Regards,
Frederik Lotter
MiX Telematics South Africa

--===============7713865786870152250==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGJyPjxicj5JdCBsb29rcyBsaWtlIHRoZSBTTVMgcmVjZWl2ZSBB
UEkgYXR0ZW1wdHMgdG8gcmVwcmVzZW50IHRoZSBpbmNvbWluZyBTTVMgYXMgYW4gYXJyYXkgb2Yg
Y2hhcmFjdGVycyBpbnNpZGUgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uLjxicj48YnI+SW5jb21pbmdN
ZXNzYWdlKHN0cmluZyBtZXNzYWdlLCBkaWN0IGluZm8pPGJyPjxicj5JIGFtIGV4cGVjdGluZyBh
IHJhdyBwYXlsb2FkIG9mIHNlcnZlciBkYXRhIHZpYSBTTVMuIEkgY2Fubm90IHNlZSBob3cgdGhp
cyB3aWxsIHdvcmsgaW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gc2luY2UgdGhlIHJhdyBk
YXRhIG1heSB3ZWxsIGJlIGZ1bGwgb2YgemVyb3Mgd2hpY2ggd2lsbCBhY3QgYXMgYSBzdHJpbmcg
dGVybWluYXRvci7CoDxkaXY+PGJyPjwvZGl2PjxkaXY+QW55IGlkZWFzPzwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+S2luZCBSZWdhcmRzLDwvZGl2PjxkaXY+RnJlZGVyaWsgTG90dGVyPC9kaXY+
PGRpdj5NaVggVGVsZW1hdGljcyBTb3V0aCBBZnJpY2E8YnI+PGRpdj48YnI+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============7713865786870152250==--

