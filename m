Content-Type: multipart/mixed; boundary="===============0712254000421071390=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFC 2/4] stk: Handle Launch Browser proactive command
Date: Wed, 12 Jan 2011 23:45:53 +0100
Message-ID: <AANLkTikjKnoR7di__8BKW-VCGBU5WrkCLYCcsqn3pF4y@mail.gmail.com>
In-Reply-To: <4D2E2BD4.9050303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0712254000421071390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12 January 2011 23:31, Denis Kenzior <denkenz@gmail.com> wrote:
>> +static gboolean handle_command_launch_browser(const struct stk_command =
*cmd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct stk_response *rsp,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct ofono_stk *stk)
>> +{
>> + =C2=A0 =C2=A0 const struct stk_command_launch_browser *lb =3D &cmd->la=
unch_browser;
>> + =C2=A0 =C2=A0 struct ofono_modem *modem =3D __ofono_atom_get_modem(stk=
->atom);
>> + =C2=A0 =C2=A0 static unsigned char no_cause[] =3D { 0x00 };
>> + =C2=A0 =C2=A0 static unsigned char no_service[] =3D { 0x04 };
>> + =C2=A0 =C2=A0 struct ofono_atom *netreg_atom;
>> + =C2=A0 =C2=A0 struct ofono_netreg *netreg;
>> + =C2=A0 =C2=A0 int qualifier =3D cmd->qualifier;
>> + =C2=A0 =C2=A0 char *alpha_id;
>> + =C2=A0 =C2=A0 int err;
>> + =C2=A0 =C2=A0 int status;
>> +
>> + =C2=A0 =C2=A0 if (qualifier > 3 || qualifier =3D=3D 1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D STK_RES=
ULT_TYPE_COMMAND_NOT_UNDERSTOOD;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if ( lb->browser_id > 4) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D STK_RES=
ULT_TYPE_DATA_NOT_UNDERSTOOD;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (ofono_modem_get_online(modem) =3D=3D FALSE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADD_ERROR_RESULT(rsp->result=
, STK_RESULT_TYPE_TERMINAL_BUSY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_service);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATO=
M_TYPE_NETREG);
>> + =C2=A0 =C2=A0 if (netreg_atom =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp->result.type =3D STK_RES=
ULT_TYPE_NOT_CAPABLE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 netreg =3D __ofono_atom_get_data(netreg_atom);
>> + =C2=A0 =C2=A0 status =3D __ofono_netreg_registration_status(netreg);
>> +
>> + =C2=A0 =C2=A0 if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADD_ERROR_RESULT(rsp->result=
, STK_RESULT_TYPE_TERMINAL_BUSY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_service);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
>> + =C2=A0 =C2=A0 }
>> +
>
> So a question about this. =C2=A0Why are we checking the netreg atom?
> Shouldn't we be checking the gprs atom's attached property? =C2=A0But this
> brings up an even more interesting question, do we even need to assume
> that we have to be attached to the cellular network to perform these
> operations? =C2=A0We could in theory go over wifi.

I agree that the modem online property is unrelated to this.  Also the
card may in theory specify a URL that designates a local file or
something on a local network, not the internet.

Best regards

--===============0712254000421071390==--

