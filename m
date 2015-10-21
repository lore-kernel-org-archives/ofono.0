Content-Type: multipart/mixed; boundary="===============3487101619046772595=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: Re: [PATCH 1/2 v3] emulator: add codec negotiation support
Date: Wed, 21 Oct 2015 15:18:00 +0200
Message-ID: <56279088.6090002@canonical.com>
In-Reply-To: <56278BA7.2010502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3487101619046772595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21.10.2015 14:57, Denis Kenzior wrote:
> Hi Simon,
>
> On 10/21/2015 02:42 AM, Simon Fels wrote:
>> Hey Denis,
>>
>>> Please make sure not to go over 80 chars / line.  Even if you need to
>>> indent arguments 2-4 less than what is required by our style guidelines.
>>
>> vim shows me I am at 76 chars with having 4 spaces per tab. So how many
>> spaces do you take per tab to come over 80 chars? 8 spaces?
>>
>
> We use kernel coding style, so yes, 8 spaces.
>
>>>> +
>>>>   #ifdef __cplusplus
>>>>   }
>>>>   #endif
>>>> diff --git a/src/emulator.c b/src/emulator.c
>>>> index 626dec3..e16312e 100644
>>>> --- a/src/emulator.c
>>>> +++ b/src/emulator.c
>>>> @@ -27,6 +27,7 @@
>>>>   #include <string.h>
>>>>   #include <unistd.h>
>>>>   #include <stdbool.h>
>>>> +#include <errno.h>
>>>>
>>>>   #include <glib.h>
>>>>
>>>> @@ -39,6 +40,15 @@
>>>>
>>>>   #define RING_TIMEOUT 3
>>>>
>>>> +#define CVSD_OFFSET 0
>>>> +#define MSBC_OFFSET 1
>>>> +#define CODECS_COUNT (MSBC_OFFSET + 1)
>>>> +
>>>> +struct hfp_codec_info {
>>>> +    unsigned char type;
>>>> +    ofono_bool_t supported;
>>>> +};
>>>> +
>>>>   struct ofono_emulator {
>>>>       struct ofono_atom *atom;
>>>>       enum ofono_emulator_type type;
>>>> @@ -50,6 +60,13 @@ struct ofono_emulator {
>>>>       guint callsetup_source;
>>>>       int pns_id;
>>>>       struct ofono_handsfree_card *card;
>>>> +    struct hfp_codec_info r_codecs[CODECS_COUNT];
>>>> +    unsigned char negotiated_codec;
>>>> +    unsigned char proposed_codec;
>>>> +    guint delay_sco;
>>>
>>> Is this still needed?
>>>
>>>> +    ofono_emulator_codec_negotiation_cb codec_negotiation_cb;
>>>> +    void *codec_negotiation_data;
>>>> +    ofono_bool_t bac_received;
>>>>       bool slc : 1;
>>>>       unsigned int events_mode : 2;
>>>>       bool events_ind : 1;
>>>> @@ -938,6 +955,168 @@ fail:
>>>>       }
>>>>   }
>>>>
>>>> +static void bac_cb(GAtServer *server, GAtServerRequestType type,
>>>> +            GAtResult *result, gpointer user_data)
>>>> +{
>>>> +    struct ofono_emulator *em =3D user_data;
>>>> +    GAtResultIter iter;
>>>> +    int val;
>>>> +
>>>> +    DBG("");
>>>> +
>>>> +    switch (type) {
>>>> +    case G_AT_SERVER_REQUEST_TYPE_SET:
>>>> +        g_at_result_iter_init(&iter, result);
>>>> +        g_at_result_iter_next(&iter, "");
>>>> +
>>>> +        /*
>>>> +         * CVSD codec is mandatory and must come first.
>>>> +         * See HFP v1.6 4.34.1
>>>> +         */
>>>> +        if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE ||
>>>> +                val !=3D HFP_CODEC_CVSD)
>>>> +            goto fail;
>>>> +
>>>> +        em->bac_received =3D TRUE;
>>>> +
>>>> +        em->negotiated_codec =3D 0;
>>>> +        em->r_codecs[CVSD_OFFSET].supported =3D TRUE;
>>>> +
>>>> +        while (g_at_result_iter_next_number(&iter, &val)) {
>>>> +            switch (val) {
>>>> +            case HFP_CODEC_MSBC:
>>>> +                em->r_codecs[MSBC_OFFSET].supported =3D TRUE;
>>>> +                break;
>>>> +            default:
>>>> +                DBG("Unsupported HFP codec %d", val);
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>>>> +
>>>> +        /*
>>>> +         * If we're currently in the process of selecting a codec
>>>> +         * we have to restart that now
>>>> +         */
>>>> +        if (em->proposed_codec)
>>>> +            ofono_emulator_start_codec_negotiation(em, 0, NULL, NULL);
>>>> +
>>>> +        break;
>>>> +
>>>> +    default:
>>>> +fail:
>>>> +        DBG("Process AT+BAC failed");
>>>> +        g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
>>>
>>> In theory our codec-negotiation procedure might have failed, do we want
>>> to call the callback here as well?
>>>
>>>> +        break;
>>>> +    }
>>>> +}
>>>> +
>>>> +static void finish_codec_negotiation(struct ofono_emulator *em,
>>>> +            int err)
>>>> +{
>>>> +    if (em->codec_negotiation_cb =3D=3D NULL)
>>>> +        return;
>>>> +
>>>> +    em->codec_negotiation_cb(err, em->codec_negotiation_data);
>>>> +
>>>> +    em->codec_negotiation_cb =3D NULL;
>>>> +    em->codec_negotiation_data =3D NULL;
>>>> +}
>>>> +
>>>> +static void connect_sco(struct ofono_emulator *em)
>>>> +{
>>>> +    int err;
>>>> +
>>>> +    DBG("");
>>>> +
>>>> +    em->delay_sco =3D 0;
>>>
>>> What does this do?
>>>
>>>> +
>>>> +    err =3D ofono_handsfree_card_connect_sco(em->card);
>>>
>>> ofono_handsfree_card_connect_sco function does not check for em->card
>>> being NULL.
>>>
>>>> +    if (err =3D=3D 0) {
>>>> +        finish_codec_negotiation(em, 0);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* If we have another codec we can try then lets do that */
>>>> +    if (em->negotiated_codec !=3D HFP_CODEC_CVSD) {
>>>> +        ofono_emulator_start_codec_negotiation(em, HFP_CODEC_CVSD,
>>>> +                            em->codec_negotiation_cb,
>>>> +                            em->codec_negotiation_data);
>>>
>>> Over 80 characters here again.  Indent less if you need to.
>>>
>>> ofono_handsfree_card_connect_sco won't really fail unless the kernel is
>>> not configured properly.  I'm unsure of the practical utility of this
>>> logic.  Would it be simpler to mark the wideband / negotiated codec as
>>> unsupported and simply error out here?
>>
>> This is the fallback to the mandatory codec. According to the spec this
>> one must be supported by both sides so if we have selected a different
>> one before we fallback to what must work but negotiate that first before
>> actually using it. Sure, if we end up here then something in our system
>> is wrong as when we say we support a codec we should be able to use it
>> without further problems. We can go and drop this if you think we don't
>> need it.
>
> The spec says:
> "If an (e)SCO link cannot be established according to the parameters
> required for the selected codec (e.g., basebands negotiation fails for a
> link with re-transmission although a wide band codec has been selected),
> the Codec Connection establishment procedure shall be re-started by the
> AG with the purpose of selecting a codec that can be used. The mandatory
> narrow band Codec (CVSD) shall be used before the AG gives up trying to
> establish a Codec connection."
>
> In practice, the only failure we can detect here is if setsockopt for
> BT_VOICE fails inside apply_codec_settings.  But I'm okay keeping this
> logic...

Ok.

regards,
Simon


--===============3487101619046772595==--

