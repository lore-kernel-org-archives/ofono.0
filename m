Content-Type: multipart/mixed; boundary="===============1133156234435466261=="
MIME-Version: 1.0
From: Antoine Reversat <a.reversat@gmail.com>
Subject: Re: [PATCH] Add CNAP support for isimodem
Date: Fri, 25 Feb 2011 11:34:46 -0500
Message-ID: <AANLkTimEZsTapATzrGGt=O1F3uMPJPp3JfNrx83zRqtD@mail.gmail.com>
In-Reply-To: <AANLkTimb-A6T7LynbST0kNs5NottoBmmP2P86yH=5ED8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1133156234435466261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Should I have made a second patch for the code cleanup to
isi_call_any_address_sb_proc ?

On Fri, Feb 25, 2011 at 11:33 AM, Antoine Reversat <a.reversat@gmail.com>=
 wrote:
> This one should be clean. Sorry it created a new email. I specified a
> message-id but it don't see it as a reply to my mail in gmail here.
>
> On Fri, Feb 25, 2011 at 11:28 AM, Antoine Reversat <a.reversat@gmail.co=
m> wrote:
>> ---
>> =C2=A0drivers/isimodem/voicecall.c | =C2=A0 50 +++++++++++++++++++++++++=
++++++++++++----
>> =C2=A0src/voicecall.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A05 ++-
>> =C2=A02 files changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
>> index 0a32f27..37b0eb3 100644
>> --- a/drivers/isimodem/voicecall.c
>> +++ b/drivers/isimodem/voicecall.c
>> @@ -56,8 +56,10 @@ struct isi_call {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t cause;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t addr_type;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t presentation;
>> + =C2=A0 =C2=A0 =C2=A0 uint8_t name_presentation;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t reason;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char address[20];
>> + =C2=A0 =C2=A0 =C2=A0 char name[20];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char addr_pad[4];
>> =C2=A0};
>>
>> @@ -210,10 +212,13 @@ static void isi_call_any_address_sb_proc(struct is=
i_voicecall *ivc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t len;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *addr;
>>
>> - =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &type, 2) ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 !g_isi_sb_iter_get_byte(sb, &pres, 3) ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 !g_isi_sb_iter_get_byte(sb, &len, 5) ||
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 !g_isi_sb_iter_get_alpha_tag(sb, &addr, 2 * len, 6))
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &type, 2))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &pres, 3))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &len, 5))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_alpha_tag(sb, &addr, 2 * l=
en, 6))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0call->addr_type =3D type | 0x80;
>> @@ -239,6 +244,31 @@ static void isi_call_destination_address_sb_proc(st=
ruct isi_voicecall *ivc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isi_call_any_addr=
ess_sb_proc(ivc, call, sb);
>> =C2=A0}
>>
>> +static void isi_call_origin_info_sb_proc(struct isi_voicecall *ivc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct isi_call *call,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 GIsiSubBlockIter *sb)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 uint8_t pres;
>> + =C2=A0 =C2=A0 =C2=A0 uint8_t id;
>> + =C2=A0 =C2=A0 =C2=A0 uint8_t len;
>> + =C2=A0 =C2=A0 =C2=A0 char *name;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &pres, 2))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &id, 6))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &len, 7))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_alpha_tag(sb, &name, 2 * l=
en, 8))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 DBG("Got name %s", name);
>> + =C2=A0 =C2=A0 =C2=A0 call->name_presentation =3D pres;
>> + =C2=A0 =C2=A0 =C2=A0 strncpy(call->name, name, sizeof(call->name));
>> +
>> + =C2=A0 =C2=A0 =C2=A0 g_free(name);
>> +}
>> +
>> =C2=A0static void isi_call_mode_sb_proc(struct isi_voicecall *ivc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct=
 isi_call *call,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIsiSu=
bBlockIter *sb)
>> @@ -396,13 +426,18 @@ static struct ofono_call isi_call_as_ofono_call(co=
nst struct isi_call *call)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.status =3D isi_call_status_to_clcc(call=
);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(number->number, call->address, sizeof(=
number->number));
>> + =C2=A0 =C2=A0 =C2=A0 memcpy(ocall.name, call->name, sizeof(ocall.name)=
);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0number->type =3D 0x80 | call->addr_type;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.clip_validity =3D call->presentation & =
3;
>> + =C2=A0 =C2=A0ocall.cnap_validity =3D call->name_presentation & 3;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ocall.clip_validity =3D=3D 0 && strlen(nu=
mber->number) =3D=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.clip_validi=
ty =3D 2;
>>
>> + =C2=A0 =C2=A0 =C2=A0 if (ocall.cnap_validity =3D=3D 0 && strlen(call->=
name) =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ocall.cnap_validity =
=3D 2;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ocall;
>> =C2=A0}
>>
>> @@ -513,11 +548,12 @@ static void isi_call_notify(struct ofono_voicecall=
 *ovc, struct isi_call *call)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall =3D isi_call_as_ofono_call(call);
>>
>> - =C2=A0 =C2=A0 =C2=A0 DBG("id=3D%u,%s,%u,\"%s\",%u,%u",
>> + =C2=A0 =C2=A0 =C2=A0 DBG("id=3D%u,%s,%u,\"%s\",\"%s\",%u,%u",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.id,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.direction ?=
 "terminated" : "originated",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.status,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.phone_numbe=
r.number,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ocall.name,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.phone_numbe=
r.type,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ocall.clip_validi=
ty);
>>
>> @@ -622,6 +658,10 @@ static void isi_call_status_ind_cb(const GIsiMessag=
e *msg, void *data)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0isi_call_origin_address_sb_proc(ivc, call, &iter);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case CALL_ORIGIN_INFO:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 isi_call_origin_info_sb_proc(ivc, call, &iter);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_GSM_DET=
AILED_CAUSE:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_DESTINA=
TION_PRE_ADDRESS:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case CALL_DESTINA=
TION_POST_ADDRESS:
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index d6e8539..ec001c0 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -1951,8 +1951,9 @@ void ofono_voicecall_notify(struct ofono_voicecall=
 *vc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_call *newcall;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("Got a voicecall event, status: %d, id: %=
u, number: %s"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 " called_number: %s", call->status, call->id,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 call->phone_number.number, call->called_number.number);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 " called_number: %s, called_name %s", call->status,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 call->id, call->phone_number.number,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 call->called_number.number, call->name);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0l =3D g_slist_find_custom(vc->call_list, GUIN=
T_TO_POINTER(call->id),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0call_compare_by_id);
>> --
>> 1.7.1
>>
>>
>

--===============1133156234435466261==--

