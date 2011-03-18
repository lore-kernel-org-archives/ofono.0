Content-Type: multipart/mixed; boundary="===============8780576974378571497=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/12] src: add gnss atom and agent implementation
Date: Fri, 18 Mar 2011 09:38:59 -0500
Message-ID: <4D836E83.8050104@gmail.com>
In-Reply-To: <1300451830.9383.20.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8780576974378571497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

>>> +{
>>> +     struct ofono_gnss *gnss =3D user_data;
>>> +
>>> +     gnss->default_agent =3D NULL;
>>
>> Since you're enabling CPOSR when an agent is registered, you have to
>> also guard against the case of the application exiting.  Note that the
>> agent can even exit while your CPOSR enable is in progress.  Have a peek
>> at location-reporting.c for ideas on how Lucas solved this.
>>
> Not sure if I understood correctly what you're trying to say and
> checking location-reporting.c didn't help but I can change the order in
> which things are done i.e. I can create agent first and then enable
> CPOSR. That way if the client dies we will know and can destroy the
> agent.
> =


Basically what I'm seeing is that when the application calls:

RegisterPositioningReportingAgent

you trigger CPOSR=3D1 to the modem and return a reply to the application
in the CPOSR callback.

When the application unregisters the agent, you trigger CPOSR=3D0 to the
modem and remove the agent in the callback.

Now consider what happens if the application that registered the agent
crashes or exits without unregistering the agent.  Your CPOSR reporting
is still turned on, without anyone around to handle the request.

You can handle this in a couple of ways:

- Always turn on CPOSR in the driver and get rid of the
set_position_reporting function.  Any requests going to the core with no
agent registered go to /dev/null (since I don't see a CPOS 'abort' style
functionality.

- Make sure that CPOSR is reset back to zero in both cases described above.

Regards,
-Denis

--===============8780576974378571497==--

