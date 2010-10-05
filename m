Content-Type: multipart/mixed; boundary="===============1009499305456697989=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: Re: return values of org.ofono.SupplementaryServices.Initiate
Date: Tue, 05 Oct 2010 15:41:42 +0300
Message-ID: <4CAB1D06.50503@nokia.com>
In-Reply-To: <1286280392.17473.85.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1009499305456697989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05.10.2010 15:06, ext Marcel Holtmann wrote:
>> doc/supplementaryservices-api.txt says nothing about return values of
>> SupplementeryServices.Initiate method (or that the method can take SS
>> requests in addition to USSD). Can the API designer/implementer fix this
>> please?
>
> why don't you just send a patch for it if it is unclear?

If it was a small update I would just send a patch. But a typical return =

value for example is:

(u'CallBarring',
  (u'interrogation',
   u'AllBarringServices',
   {u'DataAllIncoming': u'disabled',
    u'DataAllOutgoing': u'disabled',
    u'DataIncomingWhenRoaming': u'disabled',
    u'DataInternationalOutgoing': u'disabled',
    u'DataInternationalOutgoingExceptHome': u'disabled',
    u'FaxAllIncoming': u'disabled',
    u'FaxAllOutgoing': u'disabled',
    u'FaxIncomingWhenRoaming': u'disabled',
    u'FaxInternationalOutgoing': u'disabled',
    u'FaxInternationalOutgoingExceptHome': u'disabled',
    u'VoiceAllIncoming': u'disabled',
    u'VoiceAllOutgoing': u'disabled',
    u'VoiceIncomingWhenRoaming': u'disabled',
    u'VoiceInternationalOutgoing': u'disabled',
    u'VoiceInternationalOutgoingExceptHome': u'disabled'}))

Now multiply this by all possible combinations of supplementary services, =

supplementary service operations and basic services. Remember the second =

argument is a variant, so it's entirely freeform. So I sought to ask about =

this on the list first.

A patch(set) that changes the API shouldn't be accepted in the first place =

if it doesn't properly update the documentation.

Regards,
Alex

--===============1009499305456697989==--

