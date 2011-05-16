Content-Type: multipart/mixed; boundary="===============9188184389293797511=="
MIME-Version: 1.0
From: Jeevaka Prabu Badrappan <jeevakaprabu@gmail.com>
Subject: Re: Adding New contact failed in Ofono
Date: Mon, 16 May 2011 11:27:14 +0300
Message-ID: <BANLkTim+Y4=WuBBBd--6H=TBhNaLrRw0ZQ@mail.gmail.com>
In-Reply-To: <BANLkTi=v=FFGF5n7m28Z+pj8J2pHr8jAcw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9188184389293797511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yuvi,

> On Mon, May 16, 2011 at 10:28 AM, Yuvaraj Ragupathi <yuvaraj.addu@gmail=
.com> wrote:
> Hi All,
>
> I am trying to add new contact in sim via following sample code
>
>
> static=C2=A0 int new_contact(struct ofono_phonebook *pb,char *num,ofono_p=
honebook_cb_t cb)
> {
> =C2=A0=C2=A0=C2=A0 struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
> =C2=A0=C2=A0=C2=A0 char cmd[50];int return_value;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(cmd,"AT+CPBW=3D10,%s,1=
29,Testing", num);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Command is %s\n",cmd);
> =C2=A0=C2=A0=C2=A0 return_value=3Dg_at_chat_send(pbd->chat,cmd, none_pref=
ix,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL,NULL, NUL=
L);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Add New contact number=
 in Sim\n Status is %d\n",return_value);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return return_value;
> }
>

I don't think there is any plan to support storing contacts to SIM
storage in the ofono core. Can be confirmed by
the Denis/Marcel.

As per the 27.007 spec,

+CPBW=3D[<index>][,<number>[,<type>[,<text>[,<group>[,<adnumber>[,<adtype>[=
,<secondtext>[,<email>[,<sip_uri>[,<tel_uri>[,<hidden>]]]]]]]]]]]

Possible response(s)

+CPBW: <written index>

+CME ERROR: <err>

Atleast as per the code, I notice that you are using none_prefix which
is not correct. Also you haven't given any callback function to handle
the result.

Regards,
Jeevaka

--===============9188184389293797511==--

