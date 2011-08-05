Content-Type: multipart/mixed; boundary="===============2506637616441031334=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gatppp: save dumpfile into ppp info to start
 recording during open phase.
Date: Fri, 05 Aug 2011 09:28:57 -0500
Message-ID: <4E3BFE29.6040709@gmail.com>
In-Reply-To: <568DE01DA537804BA73470071BAC28893905C091@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2506637616441031334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/05/2011 10:06 AM, Aygon, Bertrand wrote:
> Hi Denis,
> =

>>> @@ -541,6 +542,8 @@ gboolean g_at_ppp_open(GAtPPP *ppp, GAtIO *io)
>>>  	if (ppp->hdlc =3D=3D NULL)
>>>  		return FALSE;
>>>
>>> +	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
>>> +
> =

> I force the start of the recording in the ppp_open.
> =

> Without this change, if we call g_at_ppp_set_record before g_at_ppp_open,=
 as it's done in gsmdial, it's totaly useless. g_at_ppp_set_record will cal=
l g_at_hdlc_set_recording, and g_at_hdlc_set_recording will check ppp->hdlc=
. But ppp->hdlc is set in g_at_ppp_open.
>

Then at least do this everywhere g_at_hdlc is created...

>>>  	ppp->suspended =3D FALSE;
>>>  	g_at_hdlc_set_receive(ppp->hdlc, ppp_receive, ppp);
>>>  	g_at_hdlc_set_suspend_function(ppp->hdlc,
>>> @@ -593,7 +596,11 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const
>> char *filename)
>>>  	if (ppp =3D=3D NULL)
>>>  		return;
>>>
>>> -	g_at_hdlc_set_recording(ppp->hdlc, filename);
>>> +	g_free(ppp->dumpfile);
>>> +
>>> +	ppp->dumpfile =3D g_strdup(filename);
>>> +
>>> +	g_at_hdlc_set_recording(ppp->hdlc, ppp->dumpfile);
>>
>> I'm failing to see the point in making this change.  Why do you need to
>> save the dump filename inside gatppp?
> =

> So in the g_at_ppp_set_recording, I store the file. And during the ppp_op=
en, I start the recording immediately. So with this change, we cannot miss =
a PPP frame. Because without the change, if we start the recording after th=
e ppp_open, we might loose some info.
> =


However, I'm still not convinced we want to pay the price of storing the
filename.  Setting recording after ppp_open should be fine, all GAtHDLC
writes are deferred until the next poll/select fires, which implies
going into the main event loop.  So no data will be lost.

>>>  }
>>>
>>>  void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPConnectFunc
>> func,
>>> @@ -745,6 +752,8 @@ void g_at_ppp_unref(GAtPPP *ppp)
>>>
>>>  	g_at_hdlc_unref(ppp->hdlc);
>>>
>>> +	g_free(ppp->dumpfile);
>>> +
>>>  	g_free(ppp);
>>>  }
>>>

Regards,
-Denis

--===============2506637616441031334==--

