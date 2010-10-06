Content-Type: multipart/mixed; boundary="===============9016913966418996064=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] isimodem/voicecall: fix hangup_active
Date: Wed, 06 Oct 2010 12:56:42 +0300
Message-ID: <AANLkTimmNaN9M99QPZgE0oLa=SMO7RO4HeoRFjbFC2UR@mail.gmail.com>
In-Reply-To: <1286357645.6145.27.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9016913966418996064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/10/6 Marcel Holtmann <marcel@holtmann.org>:
>> +static void isi_hangup_active(struct ofono_voicecall *ovc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ofono_voicecall_cb_t cb, void *data)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 /* AT+CHUP */
>> - =C2=A0 =C2=A0 isi_call_release_req(ovc, CALL_ID_ALL, CALL_CAUSE_TYPE_C=
LIENT,
>> + =C2=A0 =C2=A0 isi_call_release_req(ovc, CALL_ID_ACTIVE, CALL_CAUSE_TYP=
E_CLIENT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALL_CAUSE_RELEASE_BY_USER, cb, data);
>
> while at it, you might also wanna remove the reference to an AT command.
> Seems like a copy&past leftover from the original atmodem driver.

Oh yes, the comment is no more correct. I'll do that.

-- =

Pekka.Pessi mail at nokia.com

--===============9016913966418996064==--

