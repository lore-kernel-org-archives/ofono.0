Content-Type: multipart/mixed; boundary="===============6232802864455084060=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Wed, 16 Oct 2013 10:57:47 -0500
Message-ID: <525EB77B.4030505@gmail.com>
In-Reply-To: <525E765D.1050205@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6232802864455084060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/16/2013 06:19 AM, Jonas Bonn wrote:
> On 10/16/2013 12:55 PM, Alfonso Sanchez-Beato wrote:
>> In some cases the field MNC length in EFad is not present. MNC can
>> have either 2 or 3 digits depending on the MCC: we will try with
>> those 2 lengths when searching in the database for this corner case
>> (this situation can happen for SIMs (non-USIM), as MNC lenght field
>> is not mandatory for them - see 3gpp TS 51.011)
>
> We've been here before...
>
> http://comments.gmane.org/gmane.comp.handhelds.ofono/13552
>
> Something like this is definitely needed... SIM's from at least one
> carrier in Sweden fail to provide the MNC length.
>

Feel free to improve your patch to be a bit more pedantic:
- checking for length =3D=3D 3
- making sure that EFphase was set to something sane.

I might be convinced to default to MNC length 2 in that case

Regards,
-Denis


--===============6232802864455084060==--

