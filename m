Content-Type: multipart/mixed; boundary="===============2284938667973942059=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 03/10] handsfree-audio: Remove modem dependency
Date: Mon, 04 Mar 2013 12:45:19 -0300
Message-ID: <CAKT1EBeHCACLjNRnzBSwExmbSR7c9j-+V=XJmCzd69Ms1wPh+Q@mail.gmail.com>
In-Reply-To: <513101AB.4070801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2284938667973942059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On Fri, Mar 1, 2013 at 4:29 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Claudio,
>
>
> On 02/28/2013 12:52 PM, Claudio Takahasi wrote:
>>
>> This patch replaces the handsfree modem verification by the Audio Card.
>> Audio Cards are created when the RFCOMM fd descriptor is received, and
>> registered when the service level connetion is established.
>> ---
>>   src/handsfree-audio.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>> index 14488ac..6657bc5 100644
>> --- a/src/handsfree-audio.c
>> +++ b/src/handsfree-audio.c
>> @@ -70,19 +70,12 @@ static GSList *card_list =3D 0;
>>   static guint sco_watch =3D 0;
>>   static uint16_t local_hfp_version =3D HFP_VERSION_1_6;
>>
>> -static ofono_bool_t slc_match(struct ofono_modem *modem, void *userdata)
>> +static int card_cmp(gconstpointer a, gconstpointer b)
>>   {
>> -       const char *remote =3D userdata;
>> -       const char *value =3D ofono_modem_get_string(modem, "Remote");
>> +       const struct ofono_handsfree_card *card =3D a;
>> +       const char *remote =3D b;
>>
>> -       if (value =3D=3D NULL)
>> -               return FALSE;
>> -
>> -       /* Make sure SLC has been established */
>> -       if (ofono_modem_get_powered(modem) !=3D TRUE)
>> -               return FALSE;
>> -
>> -       return g_str_equal(remote, value);
>> +       return g_strcmp0(card->remote, remote);
>>   }
>>
>>   static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
>> @@ -107,8 +100,8 @@ static gboolean sco_accept(GIOChannel *io,
>> GIOCondition cond,
>>
>>         bt_ba2str(&saddr.sco_bdaddr, remote);
>>
>> -       if (ofono_modem_find(slc_match, remote) =3D=3D NULL) {
>> -               ofono_error("Rejecting SCO: No SLC connection found!");
>> +       if (g_slist_find_custom(card_list, remote, card_cmp) =3D=3D NULL=
) {
>> +               ofono_error("Rejecting SCO: Audio Card not found!");
>>                 close(nsk);
>>                 return TRUE;
>>         }
>
>
> Please don't do it this way, I do not want to introduce irrelevant code j=
ust
> to remove it right away.  Merge this patch into the previous one or cut d=
own
> the first patch to just the bare necessities.
>
> Regards,
> -Denis

OK. I will squash it in the previous commit.

Regards,
Claudio

--===============2284938667973942059==--

