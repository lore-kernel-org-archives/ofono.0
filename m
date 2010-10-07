Content-Type: multipart/mixed; boundary="===============4824346977466940605=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: return values of org.ofono.SupplementaryServices.Initiate
Date: Wed, 06 Oct 2010 19:37:24 -0500
Message-ID: <4CAD1644.40302@gmail.com>
In-Reply-To: <4CAB1D06.50503@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4824346977466940605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 10/05/2010 07:41 AM, Alexander Kanavin wrote:
> On 05.10.2010 15:06, ext Marcel Holtmann wrote:
>>> doc/supplementaryservices-api.txt says nothing about return values of
>>> SupplementeryServices.Initiate method (or that the method can take SS
>>> requests in addition to USSD). Can the API designer/implementer fix this
>>> please?
>>
>> why don't you just send a patch for it if it is unclear?
> =

> If it was a small update I would just send a patch. But a typical return
> value for example is:
> =

> (u'CallBarring',
>  (u'interrogation',
>   u'AllBarringServices',
>   {u'DataAllIncoming': u'disabled',
>    u'DataAllOutgoing': u'disabled',
>    u'DataIncomingWhenRoaming': u'disabled',
>    u'DataInternationalOutgoing': u'disabled',
>    u'DataInternationalOutgoingExceptHome': u'disabled',
>    u'FaxAllIncoming': u'disabled',
>    u'FaxAllOutgoing': u'disabled',
>    u'FaxIncomingWhenRoaming': u'disabled',
>    u'FaxInternationalOutgoing': u'disabled',
>    u'FaxInternationalOutgoingExceptHome': u'disabled',
>    u'VoiceAllIncoming': u'disabled',
>    u'VoiceAllOutgoing': u'disabled',
>    u'VoiceIncomingWhenRoaming': u'disabled',
>    u'VoiceInternationalOutgoing': u'disabled',
>    u'VoiceInternationalOutgoingExceptHome': u'disabled'}))
> =

> Now multiply this by all possible combinations of supplementary
> services, supplementary service operations and basic services. Remember
> the second argument is a variant, so it's entirely freeform. So I sought
> to ask about this on the list first.

This is on my TODO list, but honestly it would take you no more than 2
hours to do this yourself for most of the reply types.  All the reply
generators are nicely compartmentalized (call-barring.c:
generate_ss_query_reply, call-forwarding.c: cf_ss_control_reply,
call-settings.c: generate_cw_ss_query_reply, clip_colp_colr_ss_query_cb)

And you don't really need to handle all the combinations, simply stating
that the elements returned in the dictionary were affected by the SS
operation is enough.

> =

> A patch(set) that changes the API shouldn't be accepted in the first
> place if it doesn't properly update the documentation.

This patch set predates the launch of oFono as 'oFono'.  So far nobody
has been attempting to use this API ;)

Regards,
-Denis

--===============4824346977466940605==--

