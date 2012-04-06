Content-Type: multipart/mixed; boundary="===============1182094051976344115=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: hfp voicecall fails to register in ofono with iPhone voicemail
Date: Fri, 06 Apr 2012 09:36:19 -0500
Message-ID: <4F7EFF63.4050009@gmail.com>
In-Reply-To: <CAB7rCThxStzipw-2SJ1dc03RwT-+dby1f3L9+=xdXS3HkLXrog@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1182094051976344115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On 04/05/2012 11:28 PM, Mike wrote:
> I'm experiencing an issue where the +CLCC response provided by an
> iPhone is ignored in the case of a user utilizing visual voicemail.
> The problem here is that the AT+CLCC is being sent in response to a
> +CIEV indicating call setup, but by the time the +CLCC response comes
> back, the call status is active.  This is a problem because the
> callback, sync_dialing_cb, is specifically looking for calls in the
> dialing state.  It looks like at least some bits from clcc_poll_cb
> should be copied into sync_dialing_cb (or a helper function) because I
> would think any time we get a +CLCC we would want to completely update
> our call list (and therefore fix the issue I'm encountering).  I'm
> still digging into this, but as I'm not familiar with all the quirks
> of devices out there, I'm throwing this out there in case anyone has
> some ideas on this.

Are you dialing from the HF or the AG side?  And yes, the logic in
find_dialing() might indeed need to be changed to also find single
active calls.

Regards,
-Denis

--===============1182094051976344115==--

