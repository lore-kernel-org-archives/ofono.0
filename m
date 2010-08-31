Content-Type: multipart/mixed; boundary="===============4813723502244357760=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 17:52:03 +0300
Message-ID: <AANLkTimwiTyok3aTuuXeBjdvONm1omEUEzRav=HcsEt7@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A0E1A1@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4813723502244357760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

2010/8/31  <Jeevaka.Badrappan@elektrobit.com>:
> What I meant was to provide a driver API which will take both the dcs
> and string as parameter. something like the following:
>
> enum ofono_dcs{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_DCS_UNKNOWN,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_DCS_GSM_7BIT,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_DCS_8BIT,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OFONO_DCS_UCS2,
> };
>
> void (*request)(struct ofono_ussd *ussd, int dcs, const char *str,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ofono_ussd_cb_t, void *data);
>
> If the dcs is set to OFONO_DCS_UNKNOWN, then the conversion from UTF-8
> to GSM 7 bit default alphabet needs to be done. Anything other than
> OFONO_DCS_UNKNOWN, modem driver doesn't need to do any conversion and
> sends the dcs and string as it is to the network.

Would it always make sense to do the conversion of the USSD string in
the core, not in the modem driver? So the API would be something like

 void (*request)(struct ofono_ussd *ussd, int dcs, void const *data,
size_t len,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ofono_ussd_cb_t, void *data);


-- =

Pekka.Pessi mail at nokia.com

--===============4813723502244357760==--

