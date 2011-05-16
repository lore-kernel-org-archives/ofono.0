Content-Type: multipart/mixed; boundary="===============6962844813897279337=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Adding New contact failed in Ofono
Date: Mon, 16 May 2011 12:58:30 +0530
Message-ID: <BANLkTi=v=FFGF5n7m28Z+pj8J2pHr8jAcw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6962844813897279337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am trying to add new contact in sim via following sample code


static  int new_contact(struct ofono_phonebook *pb,char
*num,ofono_phonebook_cb_t cb)
{
    struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
    char cmd[50];int return_value;
        sprintf(cmd,"AT+CPBW=3D10,%s,129,Testing", num);
        printf("Command is %s\n",cmd);
    return_value=3Dg_at_chat_send(pbd->chat,cmd, none_prefix,
                       NULL,NULL, NULL);
        printf("Add New contact number in Sim\n Status is
%d\n",return_value);
        return return_value;
}


If i try to add new contact  my Return status is  69 or 70


what is does mean?

I verified  in my Sim. Contact is not added


Thanks

Yuvi R

--===============6962844813897279337==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLDxicj48YnI+SSBhbSB0cnlpbmcgdG8gYWRkIG5ldyBjb250YWN0IGluIHNpbSB2aWEg
Zm9sbG93aW5nIHNhbXBsZSBjb2RlPGJyPjxicj48YnI+c3RhdGljoCBpbnQgbmV3X2NvbnRhY3Qo
c3RydWN0IG9mb25vX3Bob25lYm9vayAqcGIsY2hhciAqbnVtLG9mb25vX3Bob25lYm9va19jYl90
IGNiKTxicj57PGJyPqCgoCBzdHJ1Y3QgcGJfZGF0YSAqcGJkID0gb2Zvbm9fcGhvbmVib29rX2dl
dF9kYXRhKHBiKTs8YnI+CqCgoCBjaGFyIGNtZFs1MF07aW50IHJldHVybl92YWx1ZTs8YnI+oKCg
oKCgoCBzcHJpbnRmKGNtZCwmcXVvdDtBVCtDUEJXPTEwLCVzLDEyOSxUZXN0aW5nJnF1b3Q7LCBu
dW0pOzxicj6goKCgoKCgIHByaW50ZigmcXVvdDtDb21tYW5kIGlzICVzXG4mcXVvdDssY21kKTs8
YnI+oKCgIHJldHVybl92YWx1ZT1nX2F0X2NoYXRfc2VuZChwYmQtJmd0O2NoYXQsY21kLCBub25l
X3ByZWZpeCw8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgTlVMTCxOVUxMLCBOVUxMKTs8YnI+
oKCgoKCgoCBwcmludGYoJnF1b3Q7QWRkIE5ldyBjb250YWN0IG51bWJlciBpbiBTaW1cbiBTdGF0
dXMgaXMgJWRcbiZxdW90OyxyZXR1cm5fdmFsdWUpOzxicj6goKCgoKCgIHJldHVybiByZXR1cm5f
dmFsdWU7PGJyPn08YnI+PGJyPjxicj5JZiBpIHRyeSB0byBhZGQgbmV3IGNvbnRhY3SgIG15IFJl
dHVybiBzdGF0dXMgaXOgIDY5IG9yIDcwPGJyPgo8YnI+PGJyPndoYXQgaXMgZG9lcyBtZWFuPzxi
cj48YnI+SSB2ZXJpZmllZKAgaW4gbXkgU2ltLiBDb250YWN0IGlzIG5vdCBhZGRlZDxicj48YnI+
PGJyPlRoYW5rczxicj48YnI+WXV2aSBSPGJyPgo=

--===============6962844813897279337==--

