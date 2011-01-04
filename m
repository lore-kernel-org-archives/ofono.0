Content-Type: multipart/mixed; boundary="===============0888447193454372622=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v2 2/4] sim: query remaining pin retries
Date: Tue, 04 Jan 2011 15:26:13 -0200
Message-ID: <AANLkTimmSTmbY-GyBPa_hisU7E59_6S9r+ZP5JE9wLY3@mail.gmail.com>
In-Reply-To: <4D23554F.2040604@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0888447193454372622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Jan 4, 2011 at 3:13 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
> On 01/04/2011 07:06 AM, Lucas De Marchi wrote:
>> @@ -62,6 +62,8 @@ struct ofono_sim {
>> =C2=A0 =C2=A0 =C2=A0 enum ofono_sim_password_type pin_type;
>> =C2=A0 =C2=A0 =C2=A0 gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /=
* Number of PINs */
>>
>> + =C2=A0 =C2=A0 GSList *pin_retries;
>> +
>
> Are you forgetting to free the pin_retries array when the sim is removed
> or the sim atom is destroyed?
>

Yes, I forgot. Since I cannot have G* types on headers, I'll store a
ofono_sim_pin_retry **retries here and convert the code so the list
will not be necessary. Is this ok?


> The rest seems fine to me.
>

thanks
regards,


Lucas De Marchi

--===============0888447193454372622==--

