Content-Type: multipart/mixed; boundary="===============3227295378389061818=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH v2, 3/7] cdma-sms: Add CDMA SMS Support
Date: Wed, 05 Jan 2011 09:47:37 -0800
Message-ID: <4D24AEB9.4060800@nokia.com>
In-Reply-To: <4D238E7E.3020200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3227295378389061818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/04/2011 01:17 PM, ext Denis Kenzior wrote:
> Hi Lei,
>
> On 12/21/2010 06:02 PM, Lei Yu wrote:
>> ---
>>   Makefile.am        |    3 +-
>>   src/cdma-smsutil.c |  484 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   src/cdma-smsutil.h |  264 ++++++++++++++++++++++++++++
>>   3 files changed, 750 insertions(+), 1 deletions(-)
>>   create mode 100644 src/cdma-smsutil.c
>>   create mode 100644 src/cdma-smsutil.h
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index aa00016..e85f522 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -319,7 +319,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_so=
urces) src/ofono.ver \
>>                        src/radio-settings.c src/stkutil.h src/stkutil.c \
>>                        src/nettime.c src/stkagent.c src/stkagent.h \
>>                        src/simfs.c src/simfs.h src/audio-settings.c \
>> -                     src/smsagent.c src/smsagent.h src/ctm.c
>> +                     src/smsagent.c src/smsagent.h src/ctm.c \
>> +                     src/cdma-smsutil.c
>
> Make sure to include src/cdma-smsutil.h as well.
>
> I'm still not really familiar with the CDMA SMS pdu spec, so take my
> comments with a grain of salt ;)
>

Will fix.

>>
>>   src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_=
LIBS@ -ldl
>>
>> diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
>> new file mode 100644
>> index 0000000..b80002c
>> --- /dev/null
>> +++ b/src/cdma-smsutil.c
>> @@ -0,0 +1,484 @@
>> +/*
>> + *
>> + *  oFono - Open Source Telephony
>> + *
>> + *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-130=
1 USA
>> + *
>> + */
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include<config.h>
>> +#endif
>> +
>> +#define _GNU_SOURCE
>> +#include<string.h>
>> +#include<dirent.h>
>> +#include<sys/types.h>
>> +#include<sys/stat.h>
>> +#include<unistd.h>
>> +
>> +#include<glib.h>
>> +
>> +#include "cdma-smsutil.h"
>> +
>> +/*
>> + * Mapping from binary DTMF code to the digit it represents.
>> + * As defined in Table 2.7.1.3.2.4-4 of 3GPP2 C.S0005-E v2.0.
>> + * Note, 0 is NOT a valid value and not mapped to
>> + * any valid DTMF digit.
>> + */
>> +const char cdma_sms_dtmf_digits[13] =3D {0, '1', '2', '3', '4', '5', '6=
', '7',
>> +                                     '8', '9', '0', '*', '#'};
>> +
>> +
>> +/* Unpacks the byte stream. */
>> +static guint32 bit_field_unpack(const guint8 *buf, guint32 offset,
>> +                             guint32 nbit)
>> +{
>> +     guint32    val =3D 0;
>> +     guint32    byteIndex;
>> +     guint32    remainder;
>> +
>> +     if (buf =3D=3D NULL)
>> +             return 0;
>> +
>> +     byteIndex =3D  offset>>  3;
>> +     remainder =3D (offset&  0x7);
>> +
>> +     if (remainder !=3D 0) {
>> +             /*
>> +              * The field to be unpacked does not start at the byte
>> +              * boundary. Retrieve those bits first.
>> +              */
>> +             guint32    mask;
>> +
>> +             mask =3D (1<<  (8 - remainder)) - 1;
>> +             val =3D  buf[byteIndex]&  mask;
>> +
>> +             /* The field is within current byte */
>> +             if (nbit<  (8 - remainder))
>> +                     return (val>>  (8 - remainder - nbit));
>> +
>> +             /* The field at least spans till end of the byte. */
>> +             nbit -=3D  (8 - remainder);
>> +             byteIndex++;
>> +     }
>> +
>> +     /* Unpack rest of the bits in the field in 8-bit chunk. */
>> +     while (nbit>=3D 8) {
>> +             val =3D (val<<  8) | buf[byteIndex];
>> +             nbit -=3D 8;
>> +             byteIndex++;
>> +     }
>> +
>> +     /* If still some left, unpack the last remaining bits. */
>> +     if (nbit>  0)
>> +             val =3D (val<<  nbit) | (buf[byteIndex]>>  (8 - nbit));
>> +
>> +     return val;
>> +}
>
> So it looks to me like this function takes arbitrary bit fields from a
> stream.  Is this a 'peculiarity' of the address field or will this be
> used elsewhere?
>
Yes, your interpretation of the function is correct.

Actually, cross CDMA SMS spec (and also other CDMA protocol specs), a =

lot of the message (parameter and etc) structures are defined just as =

'peculiar' as Address field. For example: User Data (section 4.5.2 of =

C.S0015-B), Call Back Number (can be considered same as address).

Essentially, CDMA SMS specs defines structures as bit streams and a =

field can start at any offset within the bit stream. Even worse, =

depending on the values of the previous fields, a field can start at =

different locations within a bit stream for the different instances of =

the same type of the message.

> This looks like a really inefficient function to call for every field,
> so it might makes things easier if the offsets were simply hardcoded...
>

The main reason I do this way is that I feel there will be more chances =

to make mistake if the 'shift', 'bit-wise and', bit-wise or' operation =

is carried out when decoding each field separately. It will be cleaner =

to have this generic function and decoding of each field will just care =

about size of the field and start offset of the field into the stream.

Efficiency-wise, I see worst case a few extra machine instructions will =

be used in comparing to 'manually' decoding at each place.

For harcode the offset, I guess you mean replacing following code segment
      bit_offset +=3Dx
      next_field =3D bit_field_unpack(buf, bit_offset, next_field_len);
with something like
      next_field =3D bit_field_unpack(buf, N, next_field_len);
If this this what you mean, yes, N can be hard-coded in many places but =

still quite a few places bit_offset has to be calculated due the reasons =

explained before. But, again, efficiency-wise, this will only save one =

add instruction. If you still see a need, I can sure fix those.

>> +
>> +/* Convert CDMA DTMF digits into a string */
>> +static gboolean cdma_sms_dtmf_to_ascii(char *buf, const char *addr,
>> +                                     guint8 num_fields)
>> +{
>> +     guint8 index;
>> +     guint8 value;
>> +
>> +     if (buf =3D=3D NULL || addr =3D=3D NULL)
>> +             return FALSE;
>> +
>> +     for (index =3D 0; index<  num_fields; index++) {
>> +             if ((addr[index]<=3D 0) || (addr[index]>  12))
>> +                     return FALSE;  /* Invalid digit in address field */
>> +
>> +             value =3D (guint8) addr[index];
>> +             buf[index] =3D cdma_sms_dtmf_digits[value];
>> +     }
>> +
>> +     buf[index] =3D 0; /* Make it NULL terminated string */
>> +
>> +     return TRUE;
>> +}
>> +
>> +char *cdma_sms_address_to_string(const struct cdma_sms_address *addr)
>> +{
>> +     char *buf;
>> +
>> +     if (addr =3D=3D NULL)
>> +             return NULL;
>> +
>> +     if (addr->digit_mode !=3D DTMF_4_BIT)
>> +             return NULL; /* TODO: Only support DTMF_4_BIT currently */
>> +
>> +     buf =3D g_new(char, addr->num_fields + 1);
>> +     if (buf =3D=3D NULL)
>> +             return NULL;
>> +
>> +     if (!cdma_sms_dtmf_to_ascii(buf, addr->address, addr->num_fields))=
 {
>> +             g_free(buf);
>> +             return NULL;
>> +     }
>> +
>> +     return buf;
>> +}
>
> Does the address really need to be malloced?  We have generally tried to
> avoid this in the past.  The address usually goes directly to a
> dbus_message which takes care of copying the contents.  Since oFono is
> not multi-threaded, using a static buffer might be sufficient here.
>

Agree. Will fix.

>> +
>> +/* Decode Address parameter record */
>> +static gboolean cdma_sms_decode_addr(const unsigned char *buf, int len,
>> +                                     struct cdma_sms_address *addr)
>> +{
>> +     guint32 bit_offset =3D 0;
>> +     guint8  chari_len;
>> +     guint32 total_num_bits =3D len * 8;
>> +     guint8  index;
>> +
>> +     if (len<=3D 0 || buf =3D=3D NULL || addr =3D=3D NULL)
>> +             return FALSE;
>> +
>> +     addr->digit_mode =3D (enum cdma_sms_digit_mode)
>
> Explicit casts should be avoided

Will fix. Could you pls also educate me the rationales behind this rule?

>
>> +                             bit_field_unpack(buf, 0, 1);
>> +     bit_offset +=3D 1;
>
> Try to logically separate the fields by using an empty line between each
> one.
>

Will fix cross the file.

>> +     addr->number_mode =3D (guint8) bit_field_unpack(buf, bit_offset, 1=
);
>> +     bit_offset +=3D 1;
>> +
>> +     if (addr->digit_mode =3D=3D CODE_8_BIT) {
>> +             addr->number_type =3D (guint8)
>> +                                     bit_field_unpack(buf, bit_offset, =
3);
>> +             bit_offset +=3D 3;
>> +
>> +             if (addr->number_mode =3D=3D 0) {
>> +                     if (bit_offset + 4>  total_num_bits)
>> +                             return FALSE;
>> +
>> +                     addr->number_plan =3D (enum cdma_sms_numbering_pla=
n)
>> +                                     bit_field_unpack(buf, bit_offset, =
4);
>> +                     bit_offset +=3D 4;
>> +             }
>> +     }
>> +
>> +     if ((bit_offset + 8)>  total_num_bits)
>> +             return FALSE;
>> +
>> +     addr->num_fields =3D (guint8) bit_field_unpack(buf, bit_offset, 8);
>> +     bit_offset +=3D 8;
>> +
>> +     if (addr->digit_mode =3D=3D DTMF_4_BIT)
>> +             chari_len =3D 4;
>> +     else
>> +             chari_len =3D 8;
>> +
>> +     if ((bit_offset + chari_len * addr->num_fields)>  total_num_bits)
>> +             return FALSE;
>> +
>> +     for (index =3D 0; index<  addr->num_fields; index++) {
>> +             addr->address[index] =3D (char) bit_field_unpack(buf,
>> +                                                             bit_offset,
>> +                                                             chari_len);
>> +             bit_offset +=3D chari_len;
>> +     }
>> +
>> +     return TRUE;
>> +}
>> +
>> +char *cdma_sms_decode_text(struct cdma_sms_ud *ud)
>> +{
>> +     char *buf;
>> +
>> +     if (ud =3D=3D NULL)
>> +             return NULL;
>> +
>> +     /* TODO: Only support MSG_ENCODING_7BIT_ASCII currently */
>> +     if (ud->msg_encoding !=3D MSG_ENCODING_7BIT_ASCII)
>> +             return NULL;
>> +
>> +     buf =3D g_new(char, ud->num_fields + 1);
>> +     if (buf =3D=3D NULL)
>> +             return NULL;
>> +
>> +     memcpy(buf, ud->chari, ud->num_fields);
>> +     buf[ud->num_fields] =3D 0; /* Make it NULL terminated string */
>> +
>> +     return buf;
>> +}
>> +
>> +/* Decode User Data */
>> +static gboolean cdma_sms_decode_ud(const unsigned char *buf, int len,
>> +                                     struct cdma_sms_ud *ud)
>> +{
>> +     guint32 bit_offset =3D 0;
>> +     guint8  chari_len =3D 0;
>> +     guint32 total_num_bits =3D len * 8;
>> +     guint8  index;
>> +     enum cdma_sms_message_encoding  msg_encoding;
>> +
>> +     if (buf =3D=3D NULL || ud =3D=3D NULL)
>> +             return FALSE;
>> +
>> +     if (total_num_bits<  13)
>> +             return FALSE;
>> +
>> +     msg_encoding =3D (enum cdma_sms_message_encoding)
>> +                                     bit_field_unpack(buf, bit_offset, =
5);
>> +     ud->msg_encoding =3D  msg_encoding;
>> +     bit_offset +=3D 5;
>> +
>> +     if (ud->msg_encoding =3D=3D MSG_ENCODING_EXTENDED_PROTOCOL_MSG ||
>> +             ud->msg_encoding =3D=3D MSG_ENCODING_GSM_DATA_CODING) {
>> +             /* Skip message type field */
>> +             /* TODO: Add support for message type field */
>> +             bit_offset +=3D 8;
>> +     }
>> +
>> +     if (bit_offset + 8>  total_num_bits)
>> +             return FALSE;
>> +
>> +     ud->num_fields =3D (guint8) bit_field_unpack(buf, bit_offset, 8);
>> +     bit_offset +=3D 8;
>> +
>> +     switch (msg_encoding) {
>> +     case MSG_ENCODING_OCTET:
>> +             chari_len =3D 8;
>> +             break;
>> +     case MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
>> +             return FALSE; /* TODO */
>> +     case MSG_ENCODING_7BIT_ASCII:
>> +     case MSG_ENCODING_IA5:
>> +             chari_len =3D 7;
>> +             break;
>> +     case MSG_ENCODING_UNICODE:
>> +     case MSG_ENCODING_SHIFT_JIS:
>> +     case MSG_ENCODING_KOREAN:
>> +             return FALSE; /* TODO */
>> +     case MSG_ENCODING_LATIN_HEBREW:
>> +     case MSG_ENCODING_LATIN:
>> +             chari_len =3D 8;
>> +             break;
>> +     case MSG_ENCODING_GSM_7BIT:
>> +             chari_len =3D 7;
>> +             break;
>> +     case MSG_ENCODING_GSM_DATA_CODING:
>> +             return FALSE; /* TODO */
>> +     }
>> +
>> +     if (chari_len =3D=3D 0)
>> +             return FALSE;
>> +
>> +     if (bit_offset + chari_len * ud->num_fields>  total_num_bits)
>> +             return FALSE;
>> +
>> +     for (index =3D 0; index<  ud->num_fields; index++) {
>> +             ud->chari[index] =3D (guint8) bit_field_unpack(buf,
>> +                                                             bit_offset,
>> +                                                             chari_len);
>> +             bit_offset +=3D chari_len;
>> +     }
>> +
>> +     return TRUE;
>> +}
>> +
>> +/* Decode Message Identifier */
>> +static gboolean cdma_sms_decode_message_id(const unsigned char *buf, in=
t len,
>> +                                             struct cdma_sms_identifier=
 *id)
>> +{
>> +     guint32 bit_offset =3D 0;
>> +
>> +     if (buf =3D=3D NULL || id =3D=3D NULL)
>> +             return FALSE;
>> +
>> +     if (len !=3D 3)
>> +             return FALSE;
>> +
>> +     id->msg_type =3D (enum cdma_sms_msg_type)
>> +                     bit_field_unpack(buf, bit_offset, 4);
>> +     bit_offset +=3D 4;
>> +     id->msg_id =3D (guint16) bit_field_unpack(buf, bit_offset, 16);
>> +     bit_offset +=3D 16;
>> +     id->header_ind =3D (gboolean) bit_field_unpack(buf, bit_offset, 1);
>> +
>> +     return TRUE;
>> +}
>> +
>> +/* Decode Bearer Data */
>> +static gboolean cdma_sms_decode_bearer_data(const unsigned char *buf, i=
nt len,
>> +                             struct cdma_sms_bearer_data *bearer_data)
>> +{
>> +     gboolean ret =3D TRUE;
>> +     enum cdma_sms_subparam_id subparam_id;
>> +     guint8 subparam_len;
>> +
>> +     if (buf =3D=3D NULL || bearer_data =3D=3D NULL)
>> +             return FALSE;
>> +
>
> Have you looked at how STK pdus are decoded in stkutil.c,
> parse_dataobj() in particular.  Looking at the basic code structure so
> far, that design pattern could be (or not) a really nice fit here and
> save you some kLoC in the future.
>

Looked at it. I am assuming that the design pattern you are referring to =

is that we can create an array of structure where decoding function for =

a parameter record can be stored thus, this part of the code will be =

reduced to something like: parsing the type and invoke the decoding =

function (dataobj_handler as in stkutil.c) as in the array of the =

function handlers.

I don't see this approach and the approach I described above are really =

not much differences since the logics below are nothing but a big =

switch-case state which will be required even with function handler =

array approach anyway.

The only simplification I can see below is to somehow to put =

set_bitmap() into one place. This will reduce ~30 LOC.

>> +     while (len !=3D 0) {
>> +
>> +             if (len<  2)
>> +                     return FALSE;
>> +
>> +             subparam_id =3D (enum cdma_sms_subparam_id)
>> +                             bit_field_unpack(buf, 0, 8);
>> +             buf +=3D 1;
>> +             subparam_len =3D (guint8) bit_field_unpack(buf, 0, 8);
>> +             buf +=3D 1;
>> +
>> +             len -=3D 2;
>> +
>> +             if (len<  subparam_len)
>> +                     return FALSE;
>> +
>> +             switch (subparam_id) {
>> +             case CDMA_SMS_SUBPARAM_ID_MESSAGE_ID:
>> +                     ret =3D cdma_sms_decode_message_id(buf, subparam_l=
en,
>> +&bearer_data->id);
>> +                     set_bitmap(&bearer_data->subparam_bitmap,
>> +                                     CDMA_SMS_SUBPARAM_ID_MESSAGE_ID);
>> +                     break;
>> +             case CDMA_SMS_SUBPARAM_ID_USER_DATA:
>> +                     ret =3D cdma_sms_decode_ud(buf, subparam_len,
>> +&bearer_data->ud);
>> +                     set_bitmap(&bearer_data->subparam_bitmap,
>> +                                     CDMA_SMS_SUBPARAM_ID_USER_DATA);
>> +                     break;
>> +             case CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE:
>> +             case CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP:
>> +             case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE:
>> +             case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE:
>> +             case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE:
>> +             case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE:
>> +             case CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR:
>> +             case CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR:
>> +             case CDMA_SMS_SUBPARAM_ID_REPLY_OPTION:
>> +             case CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES:
>> +             case CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY:
>> +             case CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR:
>> +             case CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER:
>> +             case CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE:
>> +             case CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA:
>> +             case CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX:
>> +             case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA:
>> +             case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT:
>> +             case CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS:
>> +             case CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE:
>> +             case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN:
>> +             case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN_ACK:
>> +                     /*
>> +                      * TODO: Ignore any unsupported parameter.
>> +                      * Also ignore any un-recognized parameter for
>> +                      * future standard revision.
>> +                      */
>> +                     break;
>> +             }
>> +
>> +             if (ret =3D=3D FALSE)
>> +                     return FALSE;
>> +
>> +             len -=3D subparam_len;
>> +             buf +=3D subparam_len;
>> +     }
>> +
>> +     return TRUE;
>> +}
>> +
>> +static gboolean cdma_sms_p2p_decode(const unsigned char *pdu, int len,
>> +                                     struct cdma_sms *incoming)
>> +{
>> +     gboolean ret =3D TRUE;
>> +     enum cdma_sms_param_id rec_id;
>> +     guint8 rec_len;
>> +
>> +     if (pdu =3D=3D NULL || incoming =3D=3D NULL)
>> +             return FALSE;
>> +
>> +     while (len !=3D 0) {
>> +
>> +             if (len<=3D 2)
>> +                     return FALSE;
>> +
>> +             rec_id =3D (enum cdma_sms_param_id) bit_field_unpack(pdu, =
0, 8);
>> +             pdu +=3D 1;
>> +             rec_len =3D (guint8) bit_field_unpack(pdu, 0, 8);
>> +             pdu +=3D 1;
>> +
>> +             len -=3D 2;
>> +
>> +             if (len<  rec_len)
>> +                     return FALSE;
>> +
>> +             switch (rec_id) {
>> +             case CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER:
>> +                     incoming->p2p_msg.teleservice_id =3D
>> +                             (enum cdma_sms_teleservice_id)
>> +                                     bit_field_unpack(pdu, 0, 16);
>> +                     set_bitmap(&incoming->p2p_msg.param_bitmap,
>> +                             CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER);
>> +                     break;
>> +             case CDMA_SMS_PARAM_ID_SERVICE_CATEGORY:
>> +                     break; /* TODO */
>> +             case CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS:
>> +                     ret =3D cdma_sms_decode_addr(pdu, rec_len,
>> +&incoming->p2p_msg.oaddr);
>> +                     set_bitmap(&incoming->p2p_msg.param_bitmap,
>> +                                     CDMA_SMS_PARAM_ID_ORIGINATING_ADDR=
ESS);
>> +                     break;
>> +             case CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS:
>> +             case CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS:
>> +             case CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS:
>> +             case CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION:
>> +             case CDMA_SMS_PARAM_ID_CAUSE_CODE:
>> +                     break; /* TODO */
>> +             case CDMA_SMS_PARAM_ID_BEARER_DATA:
>> +                     ret =3D cdma_sms_decode_bearer_data(pdu, rec_len,
>> +&incoming->p2p_msg.bearer_data);
>> +                     set_bitmap(&incoming->p2p_msg.param_bitmap,
>> +                                     CDMA_SMS_PARAM_ID_BEARER_DATA);
>> +                     break;
>> +             }
>> +
>> +             if (!ret)
>> +                     return FALSE;
>> +
>> +             len -=3D rec_len;
>> +             pdu +=3D rec_len;
>> +     }
>> +
>> +     return TRUE;
>> +}
>> +
>> +gboolean cdma_sms_decode(const unsigned char *pdu, int len,
>> +                             struct cdma_sms *incoming)
>> +{
>> +     gboolean ret =3D FALSE;
>
> The preference is not to initialize this variable.  If you can't find a
> nicer way around it, and if the compiler complains, then use the
> uninitialized_var() trick from smsutil.c.
>

Will fix.

>> +
>> +     if ((len =3D=3D 0) || (pdu =3D=3D NULL) || (incoming =3D=3D NULL))
>> +             return FALSE;
>> +
>> +     incoming->type =3D (enum cdma_sms_tp_msg_type)
>> +                             bit_field_unpack(pdu, 0, 8);
>> +     pdu +=3D 1;
>> +     len -=3D 1;
>> +
>> +     switch (incoming->type) {
>> +     case CDMA_SMS_P2P:
>> +             ret =3D cdma_sms_p2p_decode(pdu, len, incoming);
>
> I suggest a simple return cdma_sms_p2p_decode() here..
>

Will fix.

>> +             break;
>> +     case CDMA_SMS_BCAST:
>> +     case CDMA_SMS_ACK:
>> +             /* TODO: Not supported yet */
>> +             ret =3D FALSE;
>> +             break;
>
> and a return FALSE here
>

Will fix.

>> +     }
>> +
>> +     return ret;
>
> and a return FALSE here.
>

Will fix.

>> +}
>> diff --git a/src/cdma-smsutil.h b/src/cdma-smsutil.h
>> new file mode 100644
>> index 0000000..bfe2abb
>> --- /dev/null
>> +++ b/src/cdma-smsutil.h
>> @@ -0,0 +1,264 @@
>> +/*
>> + *
>> + *  oFono - Open Source Telephony
>> + *
>> + *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 as
>> + *  published by the Free Software Foundation.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-130=
1 USA
>> + *
>> + */
>> +
>> +/* 3GPP2 C.S0015-B v2.0, Table 3.4-1 */
>> +enum cdma_sms_tp_msg_type {
>> +     CDMA_SMS_P2P =3D          0,
>> +     CDMA_SMS_BCAST =3D        1,
>> +     CDMA_SMS_ACK =3D          2
>> +};
>> +
>> +/* 3GPP2 X.S0004-550-E, Section 2.256 */
>> +enum cdma_sms_teleservice_id {
>> +     TELESERVICE_CMT91 =3D     4096,
>> +     TELESERVICE_WPT =3D       4097,
>> +     TELESERVICE_WMT =3D       4098,
>> +     TELESERVICE_VMN =3D       4099,
>> +     TELESERVICE_WAP =3D       4100,
>> +     TELESERVICE_WEMT =3D      4101,
>> +     TELESERVICE_SCPT =3D      4102,
>> +     TELESERVICE_CATPT =3D     4103
>> +};
>> +
>> +/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-2 */
>> +enum cdma_sms_digi_number_type {
>> +     CDMA_SMS_NUM_TYPE_UNKNOWN =3D                     0,
>> +     CDMA_SMS_NUM_TYPE_INTERNATIONAL_NUMBER =3D        1,
>> +     CDMA_SMS_NUM_TYPE_NATIONAL_NUMBER =3D             2,
>> +     CDMA_SMS_NUM_TYPE_NETWORK_SPECIFIC_NUMBER =3D     3,
>> +     CDMA_SMS_NUM_TYPE_SUBSCRIBER_NUMBER =3D           4,
>> +     /* Reserved 5 */
>> +     CDMA_SMS_NUM_TYPE_ABBREVIATED_NUMBER =3D          6
>> +     /* Reserved 7 */
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.3.3-1 */
>> +enum cdma_sms_data_network_number_type {
>> +     CDMA_SMS_NETWORK_NUM_TYPE_UNKNOWN =3D             0,
>> +     CDMA_SMS_NETWORK_TYPE_INTERNET_PROTOCOL =3D       1,
>> +     CDMA_SMS_NETWORK_TYPE_INTERNET_EMAIL_ADDRESS =3D  2,
>> +     /* All Other Values Reserved */
>> +};
>> +
>> +/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-3 */
>> +enum cdma_sms_numbering_plan {
>> +     CDMA_SMS_NUMBERING_PLAN_UNKNOWN =3D       0,
>> +     CDMA_SMS_NUMBERING_PLAN_ISDN =3D          1,
>> +     CDMA_SMS_NUMBERING_PLAN_DATA =3D          3,
>> +     CDMA_SMS_NUMBERING_PLAN_TELEX =3D         4,
>> +     CDMA_SMS_NUMBERING_PLAN_PRIVATE =3D       9,
>> +     CDMA_SMS_NUMBERING_PLAN_RESERVED =3D      15
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 4.5.1-1 */
>> +enum cdma_sms_msg_type {
>> +     CDMA_SMS_RESERVED =3D     0,
>> +     CDMA_SMS_DELIVER =3D      1,
>> +     CDMA_SMS_SUBMIT =3D       2,
>> +     CDMA_SMS_CANCEL =3D       3,
>> +     CDMA_SMS_DELIVER_ACK =3D  4,
>> +     CDMA_SMS_USER_ACK =3D     5,
>> +     CDMA_SMS_READ_ACK =3D     6,
>> +};
>> +
>> +/* C.R1001-G_v1.0 Table 9.1-1 */
>> +enum cdma_sms_message_encoding {
>> +     MSG_ENCODING_OCTET =3D                    0,
>> +     MSG_ENCODING_EXTENDED_PROTOCOL_MSG =3D    1,
>> +     MSG_ENCODING_7BIT_ASCII =3D               2,
>> +     MSG_ENCODING_IA5 =3D                      3,
>> +     MSG_ENCODING_UNICODE =3D                  4,
>> +     MSG_ENCODING_SHIFT_JIS =3D                5,
>> +     MSG_ENCODING_KOREAN =3D                   6,
>> +     MSG_ENCODING_LATIN_HEBREW =3D             7,
>> +     MSG_ENCODING_LATIN =3D                    8,
>> +     MSG_ENCODING_GSM_7BIT =3D                 9,
>> +     MSG_ENCODING_GSM_DATA_CODING =3D          10
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.3-1 */
>> +enum cdma_sms_param_id {
>> +     CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER  =3D     0x00,
>> +     CDMA_SMS_PARAM_ID_SERVICE_CATEGORY =3D            0x01,
>> +     CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS =3D         0x02,
>> +     CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS =3D      0x03,
>> +     CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS =3D         0x04,
>> +     CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS =3D      0x05,
>> +     CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION =3D         0x06,
>> +     CDMA_SMS_PARAM_ID_CAUSE_CODE =3D                  0x07,
>> +     CDMA_SMS_PARAM_ID_BEARER_DATA =3D                 0x08
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 4.5-1 */
>> +enum cdma_sms_subparam_id {
>> +     CDMA_SMS_SUBPARAM_ID_MESSAGE_ID =3D                       0x00,
>> +     CDMA_SMS_SUBPARAM_ID_USER_DATA =3D                        0x01,
>> +     CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE =3D               0x02,
>> +     CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP =3D                    0x03,
>> +     CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE =3D         0x04,
>> +     CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE =3D         0x05,
>> +     CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE =3D  0x06,
>> +     CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE =3D  0x07,
>> +     CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR =3D               0x08,
>> +     CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR =3D                0x09,
>> +     CDMA_SMS_SUBPARAM_ID_REPLY_OPTION =3D                     0x0A,
>> +     CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES =3D               0x0B,
>> +     CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY =3D        0x0C,
>> +     CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR =3D               0x0D,
>> +     CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER =3D                 0x0E,
>> +     CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE =3D             0x0F,
>> +     CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA =3D      0x10,
>> +     CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX =3D            0x11,
>> +     CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA =3D    0x12,
>> +     CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT =3D  0x13,
>> +     CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS =3D                   0x14,
>> +     CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE =3D                 0x15,
>> +     CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN =3D                     0x16,
>> +     CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN_ACK =3D                 0x17
>> +};
>> +
>> +/* 3GPP2 C.R1001-G Table 9.3.1-1 */
>> +enum cdma_sms_service_category {
>> +     SERVICE_CAT_EMERGENCY_BROADCAST =3D               1,
>> +     SERVICE_CAT_ADMINISTRATIVE =3D                    2,
>> +     SERVICE_CAT_MAINTENANCE =3D                       3,
>> +     SERVICE_CAT_GENERALNEWSLOCAL =3D                  4,
>
> Please use the underscore some more, e.g. GENERAL_NEWS_LOCAL
>

Will fix.

>> +     SERVICE_CAT_GENERALNEWSREGIONAL =3D               5,
>> +     SERVICE_CAT_GENERALNEWSNATIONAL =3D               6,
>> +     SERVICE_CAT_GENERALNEWSINTERNATIONAL =3D          7,
>> +     SERVICE_CAT_BUSINESSFINALNEWSLOCAL =3D            8,
>> +     SERVICE_CAT_BUSINESSFINALNEWSREGIONAL =3D         9,
>> +     SERVICE_CAT_BUSINESSFINALNEWSNATIONAL =3D         10,
>> +     SERVICE_CAT_BUSINESSFINALNEWSINTNL =3D            11,
>> +     SERVICE_CAT_SPORTSNEWSLOCAL =3D                   12,
>> +     SERVICE_CAT_SPORTSNEWSREGIONAL =3D                13,
>> +     SERVICE_CAT_SPORTSNEWSNATIONAL =3D                14,
>> +     SERVICE_CAT_SPORTSNEWSINTERNATIONAL =3D           15,
>> +     SERVICE_CAT_ENTERTAINMENTNEWSLOCAL =3D            16,
>> +     SERVICE_CAT_ENTERTAINMENTNEWSREGIONAL =3D         17,
>> +     SERVICE_CAT_ENTERTAINMENTNEWSNATIONAL =3D         18,
>> +     SERVICE_CAT_ENTERTAINMENTNEWSINTERNATIONAL =3D    19,
>> +     SERVICE_CAT_ENTERTAINMENTNEWSLOCALWEATHER =3D     20,
>> +     SERVICE_CAT_AREATRAFFICREPORTS =3D                21,
>> +     SERVICE_CAT_LOCALAIRTPORTFLIGHTSCHEDULES =3D      22,
>> +     SERVICE_CAT_RESTURANTS =3D                        23,
>
> Is this mis-spelled?
>

Yep. Will fix. I am sure by now you already start wondering: what the =

heck is wrong with those CDMA folks, why can't they just use GSM? :-)

>> +     SERVICE_CAT_LODGINGS =3D                          24,
>> +     SERVICE_CAT_RETAILDIRECTORYADVERTISEMENTS =3D     25,
>> +     SERVICE_CAT_ADVERTISEMENTS =3D                    26,
>> +     SERVICE_CAT_STOCKQUOTES =3D                       27,
>> +     SERVICE_CAT_EMPLOYMENTOPPORTUNITIES =3D           28,
>> +     SERVICE_CAT_MEDICALHEALTHHOSPITALS =3D            29,
>> +     SERVICE_CAT_TECHNOLOGYNEWS =3D                    30,
>> +     SERVICE_CAT_MULTICATEGORY =3D                     31,
>> +     SERVICE_CAT_CAPT =3D                              32
>> +};
>> +
>> +enum cdma_sms_digit_mode {
>> +     DTMF_4_BIT =3D    0,
>> +     CODE_8_BIT =3D    1
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
>> +struct cdma_sms_address {
>> +     enum cdma_sms_digit_mode digit_mode;
>> +     guint8 number_mode;
>> +     guint8 number_type;
>> +     enum cdma_sms_numbering_plan number_plan;
>> +     guint8 num_fields;
>> +     char address[256];
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.6 */
>> +struct cdma_sms_cause_code {
>> +     guint8 reply_seq;
>> +     guint8 error_class;
>> +     guint8 cause_code;
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Section 4.5.1 */
>> +struct cdma_sms_identifier {
>> +     enum cdma_sms_msg_type msg_type;
>> +     guint16 msg_id;
>> +     gboolean header_ind;
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Section 4.5.2 */
>> +struct cdma_sms_ud {
>> +     enum cdma_sms_message_encoding msg_encoding;
>> +     guint8  num_fields;
>> +     guint8  chari[512];
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Section 4.5 */
>> +struct cdma_sms_bearer_data {
>> +     guint32 subparam_bitmap;
>> +     struct cdma_sms_identifier id;
>> +     struct cdma_sms_ud ud;
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.1-1. */
>> +struct cdma_sms_p2p_msg {
>> +     guint32 param_bitmap;
>> +     enum cdma_sms_teleservice_id teleservice_id;
>> +     struct cdma_sms_address oaddr;
>> +     struct cdma_sms_bearer_data bearer_data;
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.2-1 */
>> +struct cdma_sms_broadcast_msg {
>> +     enum cdma_sms_service_category service_category;
>> +     struct cdma_sms_bearer_data bearer_data;
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.3-1 */
>> +struct cdma_sms_ack_msg {
>> +     struct cdma_sms_address daddr;
>> +     struct cdma_sms_cause_code cause_code;
>> +};
>> +
>> +/* 3GPP2 C.S0015-B v2.0 Section 3.4.1 */
>> +struct cdma_sms {
>> +     enum cdma_sms_tp_msg_type type;
>> +     union {
>> +             struct cdma_sms_p2p_msg p2p_msg;
>> +             struct cdma_sms_broadcast_msg broadcast_msg;
>> +             struct cdma_sms_ack_msg ack_msg;
>> +     };
>> +};
>> +
>> +static inline gboolean check_bitmap(guint32 bitmap, guint32 pos)
>> +{
>> +     guint32 mask =3D 0x1<<  pos;
>> +     return bitmap&  mask ? TRUE : FALSE;
>> +}
>> +
>
> I don't see this function being used by this patch.  Does it logically
> belong to a later patch?
>

Yes, it is used by a later patch of the same serie: 4/7. I will split =

the patch to move this part to 4/7 if you see a need.

>> +static inline void set_bitmap(guint32 *bitmap, guint32 pos)
>> +{
>> +     if (bitmap =3D=3D NULL)
>> +             return;
>> +
>> +     *bitmap =3D *bitmap | (1<<  pos);
>> +}
>
> Why are these functions defined in the header?  Are they meant to be
> used elsewhere?
>

It is only used by cdma-smsutil.c. I will fix this by moving it into =

cdma-smsutil.c instead of putting it here in .h.

>> +
>> +gboolean cdma_sms_decode(const unsigned char *pdu, int len,
>> +                             struct cdma_sms *out);
>> +char *cdma_sms_decode_text(struct cdma_sms_ud *ud);
>> +char *cdma_sms_address_to_string(const struct cdma_sms_address *addr);
>
> Regards,
> -Denis

Regards,
-Lei

--===============3227295378389061818==--

