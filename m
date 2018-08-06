Content-Type: multipart/mixed; boundary="===============9182383737825565508=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: atmodem driver cnmi
Date: Mon, 06 Aug 2018 11:37:46 -0500
Message-ID: <41ede655-1e8b-d514-b5b2-0875e888bba2@gmail.com>
In-Reply-To: <CAKSBH7EtCB-pzx9pwYZRUqEf+CRTKKOSmA+eaTs8asoJDS+Qsw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9182383737825565508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 08/06/2018 11:33 AM, Giacinto Cifelli wrote:
> Dear all,
> =

> I have a question for the function build_cnmi_string() in =

> plugins/atmodem/sms.c
> =

> The numeric values appear corrupted, like "2310" instead of "2".
> =

> example, from an excerpt:
> `default:
> /* Sounds like 2 is the sanest mode */
> mode =3D "2310";
> break;
> `
> =

> Am I missing something, like a post-processing, or some specific =


Yes, you're missing the fact that append_cnmi_element uses wanted_cnmi, =

which selects the 'best' cnmi mode based on the reported modem capability.

> implementation not compliant with the 3GPP TS_27.005, or there is a =

> problem with this function?
> =


Regards,
-Denis

--===============9182383737825565508==--

