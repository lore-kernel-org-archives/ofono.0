Content-Type: multipart/mixed; boundary="===============8083937257198135547=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] handsfree-audio: Add .Connect using the card driver
Date: Wed, 27 Mar 2013 09:32:07 -0500
Message-ID: <515302E7.7080100@gmail.com>
In-Reply-To: <20130327142230.GB2715@samus>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8083937257198135547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 03/27/2013 09:22 AM, Vinicius Costa Gomes wrote:
> Hi Denis,
>
> On 23:59 Tue 26 Mar, Denis Kenzior wrote:
>> Hi Vinicius,
>>
>> On 03/26/2013 04:28 PM, Vinicius Costa Gomes wrote:
>>> Now each handsfree implementation may be notified that a card wants
>>> its audio to be connected.
>>>
>>> In case, that the cards wishes to fallback to the default SCO connection
>>> procedure, it just needs to return -ENOSYS.
>>
>> Are you interpreting section 4.11.2:
>> "For all HF initiated audio connection establishments for which both
>> sides support the Codec Negotiation feature, the HF shall trigger
>> the AG to establish a Codec Connection. This is necessary because
>> only the AG knows about the codec selection and settings of the
>> network."
>>
>> ... to mean that AT+BCC is only sent when both sides support codec
>> negotiation?  e.g. if one or the other side does not support codec
>> negotiation, then we are supposed to fall back to old SCO
>> establishment rules procedures?
>
> Yes. This behaviour is even covered in one of the PTS tests: TP/ACC/BV-03=
-I
> (from the description of the test, "To verify the capability of the HF
> initiating a legacy audio connection with an AG that does not support the
> Codec Connection setup procedure. The HF should be able to correctly nego=
tiate
> a working legacy audio connection to the AG.")
>

Okay, that makes things a little harder since we cannot determine the =

driver to use until the SLC is established.

<snip>

>>> +	if (!driver || !driver->connect)
>>> +		goto fallback;
>>> +
>>> +	err =3D driver->connect(card, card_connect_reply_cb, card);
>>> +	if (err =3D=3D -EINPROGRESS) {
>>> +		card->msg =3D dbus_message_ref(msg);
>>> +		return NULL;
>>
>> As mentioned earlier, the driver should not return an int, however,
>> lets revisit this part.  I want to better understand the AT+BCC and
>> codec negotiation interactions.
>
>
> Of course.
>
> Another thing that may make sense to bring up now is the AG case: if we w=
ant
> to have a HFP 1.6 capable AG, we may want to select the codec (send a +BC=
S)
> before establishing the SCO connection. I was thinking of setting a speci=
fic
> error code in the callback to signify that the core handsfree-audio may
> connect the SCO at that point.
>

I thought of setting error codes in callbacks, but I'm not happy with =

that solution.  Perhaps we should make SCO establishment a part of the =

card utility API.  e.g. ofono_handsfree_card_connect_sco().  That way =

the AG can run the required +BCS transactions and call the above =

function when it comes to making the SCO connection.

For HFP 1.6/1.5, we can either use +BCC or call =

ofono_handsfree_card_connect_sco directly.

Thoughts, other ideas?

Regards,
-Denis

--===============8083937257198135547==--

