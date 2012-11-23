Content-Type: multipart/mixed; boundary="===============2079775944873155189=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: Can't power on modem
Date: Fri, 23 Nov 2012 17:26:20 +0100
Message-ID: <CABvLYuABScaWL4gq_SUdbaofv155BRpKS+ppt=dXL7wAHvifjQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2079775944873155189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yevhen,

I've seen the same issue before with an Huawei modem.
It looks like not all modems can handle sending "ATE0 +CMEE=3D1" to the mod=
em
and pcui port simultaneously.

Try removing this line from huawei_enable():
g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);

Regards,
Cedric

--===============2079775944873155189==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgWWV2aGVuLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7dmUgc2VlbiB0aGUgc2FtZSBpc3N1
ZSBiZWZvcmUgd2l0aCBhbiBIdWF3ZWkgbW9kZW0uoDwvZGl2PjxkaXY+SXQgbG9va3MgbGlrZSBu
b3QgYWxsIG1vZGVtcyBjYW4gaGFuZGxlIHNlbmRpbmcgJnF1b3Q7QVRFMCArQ01FRT0xJnF1b3Q7
IHRvIHRoZSBtb2RlbSBhbmQgcGN1aSBwb3J0IHNpbXVsdGFuZW91c2x5LqA8L2Rpdj48ZGl2Pgo8
YnI+PC9kaXY+PGRpdj5UcnkgcmVtb3ZpbmcgdGhpcyBsaW5lIGZyb20gaHVhd2VpX2VuYWJsZSgp
OjwvZGl2PjxkaXY+Z19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FURTAgK0NN
RUU9MSZxdW90OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+Q2VkcmljPC9kaXY+Cg==

--===============2079775944873155189==--

