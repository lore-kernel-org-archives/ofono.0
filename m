Content-Type: multipart/mixed; boundary="===============3608370494445311103=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] handsfree-audio: Add function to get the codecs
Date: Fri, 05 Apr 2013 16:40:39 -0500
Message-ID: <515F44D7.5030404@gmail.com>
In-Reply-To: <20130405205626.GI2715@samus>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3608370494445311103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/05/2013 03:56 PM, Vinicius Costa Gomes wrote:
> Hi Denis,
>
> On 12:32 Fri 05 Apr, Denis Kenzior wrote:
>>>
>>> +int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
>>> +{
>>> +	int len;
>>> +
>>> +	if (agent =3D=3D NULL)
>>> +		return -EIO;
>>> +
>>> +	len =3D MIN(buffer_len, agent->codecs_len);
>>> +	memcpy(buffer, agent->codecs, len);
>>> +
>>> +	return len;
>>> +}
>>> +
>>
>> Do we really want to memcpy here or return a const unsigned char
>> array?  Also, right now we explicitly only support CVSD and mSBC, so
>> this is overkill.
>
> As we can assume that we always support CVSD, one idea is to have somethi=
ng
> like ofono_handsfree_audio_has_msbc() instead of the get_codecs() functio=
n.
> How does it sound?

I tend to like this better.  Perhaps we can name this function a more =

generic 'has_wideband()' instead.  In case we want to provide support =

for custom codecs in the future.

>
>>
>>>   static void agent_free(struct agent *agent)
>>>   {
>>>   	if (agent->watch>   0)
>>
>> Regards,
>> -Denis
>
>
> Cheers,

Regards,
-Denis

--===============3608370494445311103==--

