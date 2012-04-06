Content-Type: multipart/mixed; boundary="===============6243152530489658632=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: Re: hfp voicecall fails to register in ofono with iPhone voicemail
Date: Fri, 06 Apr 2012 10:53:36 -0500
Message-ID: <CAB7rCTiU3_T56kxjKO4Msn7=DWcOCyhTPtNLL+1S-MM-jgJ2uQ@mail.gmail.com>
In-Reply-To: <4F7EFF63.4050009@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6243152530489658632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Apr 6, 2012 at 9:36 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Mike,
>
> On 04/05/2012 11:28 PM, Mike wrote:
>> I'm experiencing an issue where the +CLCC response provided by an
>> iPhone is ignored in the case of a user utilizing visual voicemail.
>> The problem here is that the AT+CLCC is being sent in response to a
>> +CIEV indicating call setup, but by the time the +CLCC response comes
>> back, the call status is active. =C2=A0This is a problem because the
>> callback, sync_dialing_cb, is specifically looking for calls in the
>> dialing state. =C2=A0It looks like at least some bits from clcc_poll_cb
>> should be copied into sync_dialing_cb (or a helper function) because I
>> would think any time we get a +CLCC we would want to completely update
>> our call list (and therefore fix the issue I'm encountering). =C2=A0I'm
>> still digging into this, but as I'm not familiar with all the quirks
>> of devices out there, I'm throwing this out there in case anyone has
>> some ideas on this.
>
> Are you dialing from the HF or the AG side? =C2=A0And yes, the logic in
> find_dialing() might indeed need to be changed to also find single
> active calls.

Dialing is on the AG side.

Thanks,
Mike

--===============6243152530489658632==--

