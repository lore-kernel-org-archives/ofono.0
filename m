Content-Type: multipart/mixed; boundary="===============1014246835116298192=="
MIME-Version: 1.0
From: Yuvaraj Ragupathi <yuvaraj.addu@gmail.com>
Subject: Re: Adding New contact failed in Ofono
Date: Mon, 16 May 2011 14:28:05 +0530
Message-ID: <BANLkTikj9rOhs_E912bUObfRURbthnuabg@mail.gmail.com>
In-Reply-To: <BANLkTim+Y4=WuBBBd--6H=TBhNaLrRw0ZQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1014246835116298192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am doing this work for ST Ericsson modem.

Now i registered callback function for result handling and added quotes in
cmd. Now cmd is

AT+CPBW=3D10,"123456789",129,"Testing"

*Log message:*

Control @ Command is AT+CPBW=3D10,"123456789",129,"Testing"
Add New contact number in Sim
 Status is 69
 Saving contact on Sim is failed

*Code :*

static const char *cpbw_prefix[] =3D { "+CPBW:", NULL };

static void myResult(gboolean ok, GAtResult *result, gpointer user_data)
{

struct cb_data *cbd =3D user_data;
    if(!ok)
            printf(" Saving contact on Sim is failed\n");


}
static  int new_contact(struct ofono_phonebook *pb,char
*num,ofono_phonebook_cb_t cb)
{
    struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
    char cmd[50];int return_value;
        sprintf(cmd,"AT+CPBW=3D10,\"%s\",129,\"Testing\"", num);
        printf("Command is %s\n",cmd);
    return_value=3Dg_at_chat_send(pbd->chat,cmd, cpbw_prefix,
                       myResult,NULL, NULL);
        printf("Add New contact number in Sim\n Status is
%d\n",return_value);
        return return_value;
}

Thanks

Yuvi R
On Mon, May 16, 2011 at 1:57 PM, Jeevaka Prabu Badrappan <
jeevakaprabu@gmail.com> wrote:

> Hi Yuvi,
>
> > On Mon, May 16, 2011 at 10:28 AM, Yuvaraj Ragupathi <
> yuvaraj.addu(a)gmail.com> wrote:
> > Hi All,
> >
> > I am trying to add new contact in sim via following sample code
> >
> >
> > static  int new_contact(struct ofono_phonebook *pb,char
> *num,ofono_phonebook_cb_t cb)
> > {
> >     struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
> >     char cmd[50];int return_value;
> >         sprintf(cmd,"AT+CPBW=3D10,%s,129,Testing", num);
> >         printf("Command is %s\n",cmd);
> >     return_value=3Dg_at_chat_send(pbd->chat,cmd, none_prefix,
> >                        NULL,NULL, NULL);
> >         printf("Add New contact number in Sim\n Status is
> %d\n",return_value);
> >         return return_value;
> > }
> >
>
> I don't think there is any plan to support storing contacts to SIM
> storage in the ofono core. Can be confirmed by
> the Denis/Marcel.
>
> As per the 27.007 spec,
>
>
> +CPBW=3D[<index>][,<number>[,<type>[,<text>[,<group>[,<adnumber>[,<adtype=
>[,<secondtext>[,<email>[,<sip_uri>[,<tel_uri>[,<hidden>]]]]]]]]]]]
>
> Possible response(s)
>
> +CPBW: <written index>
>
> +CME ERROR: <err>
>
> Atleast as per the code, I notice that you are using none_prefix which
> is not correct. Also you haven't given any callback function to handle
> the result.
>
> Regards,
> Jeevaka
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============1014246835116298192==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5JIGFtIGRvaW5nIHRoaXMgd29yayBmb3IgU1QgRXJpY3Nzb24gbW9kZW0uPGJy
Pjxicj5Ob3cgaSByZWdpc3RlcmVkIGNhbGxiYWNrIGZ1bmN0aW9uIGZvciByZXN1bHQgaGFuZGxp
bmcgYW5kIGFkZGVkIHF1b3RlcyBpbiBjbWQuIE5vdyBjbWQgaXMgPGJyPjxicj5BVCtDUEJXPTEw
LCZxdW90OzEyMzQ1Njc4OSZxdW90OywxMjksJnF1b3Q7VGVzdGluZyZxdW90Ozxicj48YnI+Cjxi
PkxvZyBtZXNzYWdlOjwvYj48YnI+PGJyPkNvbnRyb2wgQCBDb21tYW5kIGlzIEFUK0NQQlc9MTAs
JnF1b3Q7MTIzNDU2Nzg5JnF1b3Q7LDEyOSwmcXVvdDtUZXN0aW5nJnF1b3Q7PGJyPkFkZCBOZXcg
Y29udGFjdCBudW1iZXIgaW4gU2ltPGJyPqBTdGF0dXMgaXMgNjk8YnI+oFNhdmluZyBjb250YWN0
IG9uIFNpbSBpcyBmYWlsZWQ8YnI+PGJyPjxiPkNvZGUgOjwvYj48YnI+PGJyPnN0YXRpYyBjb25z
dCBjaGFyICpjcGJ3X3ByZWZpeFtdID0geyAmcXVvdDsrQ1BCVzomcXVvdDssIE5VTEwgfTs8YnI+
Cjxicj5zdGF0aWMgdm9pZCBteVJlc3VsdChnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQs
IGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+ezxicj48YnI+c3RydWN0IGNiX2RhdGEgKmNiZCA9IHVz
ZXJfZGF0YTs8YnI+oKCgIGlmKCFvayk8YnI+oKCgIKCgoCCgoKAgcHJpbnRmKCZxdW90OyBTYXZp
bmcgY29udGFjdCBvbiBTaW0gaXMgZmFpbGVkXG4mcXVvdDspOzxicj6goKAgoKAgPGJyPgqgoKAg
PGJyPn08YnI+c3RhdGljoCBpbnQgbmV3X2NvbnRhY3Qoc3RydWN0IG9mb25vX3Bob25lYm9vayAq
cGIsY2hhciAqbnVtLG9mb25vX3Bob25lYm9va19jYl90IGNiKTxicj57PGJyPqCgoCBzdHJ1Y3Qg
cGJfZGF0YSAqcGJkID0gb2Zvbm9fcGhvbmVib29rX2dldF9kYXRhKHBiKTs8YnI+oKCgIGNoYXIg
Y21kWzUwXTtpbnQgcmV0dXJuX3ZhbHVlOzxicj6goKCgoKCgIHNwcmludGYoY21kLCZxdW90O0FU
K0NQQlc9MTAsXCZxdW90OyVzXCZxdW90OywxMjksXCZxdW90O1Rlc3RpbmdcJnF1b3Q7JnF1b3Q7
LCBudW0pOzxicj4KoKCgoKCgoCBwcmludGYoJnF1b3Q7Q29tbWFuZCBpcyAlc1xuJnF1b3Q7LGNt
ZCk7PGJyPqCgoCByZXR1cm5fdmFsdWU9Z19hdF9jaGF0X3NlbmQocGJkLSZndDtjaGF0LGNtZCwg
Y3Bid19wcmVmaXgsPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgbXlSZXN1bHQsTlVMTCwgTlVM
TCk7PGJyPqCgoKCgoKAgcHJpbnRmKCZxdW90O0FkZCBOZXcgY29udGFjdCBudW1iZXIgaW4gU2lt
XG4gU3RhdHVzIGlzICVkXG4mcXVvdDsscmV0dXJuX3ZhbHVlKTs8YnI+CqCgoKCgoKAgcmV0dXJu
IHJldHVybl92YWx1ZTs8YnI+fTxicj48YnI+VGhhbmtzPGJyPjxicj5ZdXZpIFI8YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgTWF5IDE2LCAyMDExIGF0IDE6NTcgUE0sIEplZXZh
a2EgUHJhYnUgQmFkcmFwcGFuIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmpl
ZXZha2FwcmFidUBnbWFpbC5jb20iPmplZXZha2FwcmFidUBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bh
bj4gd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIw
NCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij5IaSBZdXZpLDxicj4KPGRpdiBjbGFzcz0iaW0i
Pjxicj4KJmd0OyBPbiBNb24sIE1heSAxNiwgMjAxMSBhdCAxMDoyOCBBTSwgWXV2YXJhaiBSYWd1
cGF0aGkgJmx0OzxhIGhyZWY9Im1haWx0bzp5dXZhcmFqLmFkZHVAZ21haWwuY29tIj55dXZhcmFq
LmFkZHVAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7IEhpIEFsbCw8YnI+CiZndDs8
YnI+CiZndDsgSSBhbSB0cnlpbmcgdG8gYWRkIG5ldyBjb250YWN0IGluIHNpbSB2aWEgZm9sbG93
aW5nIHNhbXBsZSBjb2RlPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IHN0YXRpY6AgaW50IG5l
d19jb250YWN0KHN0cnVjdCBvZm9ub19waG9uZWJvb2sgKnBiLGNoYXIgKm51bSxvZm9ub19waG9u
ZWJvb2tfY2JfdCBjYik8YnI+CiZndDsgezxicj4KJmd0OyCgoKAgc3RydWN0IHBiX2RhdGEgKnBi
ZCA9IG9mb25vX3Bob25lYm9va19nZXRfZGF0YShwYik7PGJyPgomZ3Q7IKCgoCBjaGFyIGNtZFs1
MF07aW50IHJldHVybl92YWx1ZTs8YnI+CiZndDsgoKCgoKCgoCBzcHJpbnRmKGNtZCwmcXVvdDtB
VCtDUEJXPTEwLCVzLDEyOSxUZXN0aW5nJnF1b3Q7LCBudW0pOzxicj4KJmd0OyCgoKCgoKCgIHBy
aW50ZigmcXVvdDtDb21tYW5kIGlzICVzXG4mcXVvdDssY21kKTs8YnI+CiZndDsgoKCgIHJldHVy
bl92YWx1ZT1nX2F0X2NoYXRfc2VuZChwYmQtJmd0O2NoYXQsY21kLCBub25lX3ByZWZpeCw8YnI+
CiZndDsgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBOVUxMLE5VTEwsIE5VTEwpOzxicj4KJmd0OyCg
oKCgoKCgIHByaW50ZigmcXVvdDtBZGQgTmV3IGNvbnRhY3QgbnVtYmVyIGluIFNpbVxuIFN0YXR1
cyBpcyAlZFxuJnF1b3Q7LHJldHVybl92YWx1ZSk7PGJyPgomZ3Q7IKCgoKCgoKAgcmV0dXJuIHJl
dHVybl92YWx1ZTs8YnI+CiZndDsgfTxicj4KJmd0Ozxicj4KPGJyPgo8L2Rpdj5JIGRvbiYjMzk7
dCB0aGluayB0aGVyZSBpcyBhbnkgcGxhbiB0byBzdXBwb3J0IHN0b3JpbmcgY29udGFjdHMgdG8g
U0lNPGJyPgpzdG9yYWdlIGluIHRoZSBvZm9ubyBjb3JlLiBDYW4gYmUgY29uZmlybWVkIGJ5PGJy
Pgp0aGUgRGVuaXMvTWFyY2VsLjxicj4KPGJyPgpBcyBwZXIgdGhlIDI3LjAwNyBzcGVjLDxicj4K
PGJyPgorQ1BCVz1bJmx0O2luZGV4Jmd0O11bLCZsdDtudW1iZXImZ3Q7WywmbHQ7dHlwZSZndDtb
LCZsdDt0ZXh0Jmd0O1ssJmx0O2dyb3VwJmd0O1ssJmx0O2FkbnVtYmVyJmd0O1ssJmx0O2FkdHlw
ZSZndDtbLCZsdDtzZWNvbmR0ZXh0Jmd0O1ssJmx0O2VtYWlsJmd0O1ssJmx0O3NpcF91cmkmZ3Q7
WywmbHQ7dGVsX3VyaSZndDtbLCZsdDtoaWRkZW4mZ3Q7XV1dXV1dXV1dXV08YnI+Cjxicj4KUG9z
c2libGUgcmVzcG9uc2Uocyk8YnI+Cjxicj4KK0NQQlc6ICZsdDt3cml0dGVuIGluZGV4Jmd0Ozxi
cj4KPGJyPgorQ01FIEVSUk9SOiAmbHQ7ZXJyJmd0Ozxicj4KPGJyPgpBdGxlYXN0IGFzIHBlciB0
aGUgY29kZSwgSSBub3RpY2UgdGhhdCB5b3UgYXJlIHVzaW5nIG5vbmVfcHJlZml4IHdoaWNoPGJy
PgppcyBub3QgY29ycmVjdC4gQWxzbyB5b3UgaGF2ZW4mIzM5O3QgZ2l2ZW4gYW55IGNhbGxiYWNr
IGZ1bmN0aW9uIHRvIGhhbmRsZTxicj4KdGhlIHJlc3VsdC48YnI+Cjxicj4KUmVnYXJkcyw8YnI+
CkplZXZha2E8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9u
by5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9u
by5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zvbm8u
b3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj4K

--===============1014246835116298192==--

