Content-Type: multipart/mixed; boundary="===============8217087404679168033=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFCv2] doc: Assisted Satellite Navigation API and Agent API
Date: Tue, 23 Nov 2010 18:15:07 +0100
Message-ID: <AANLkTi=dxaXQ1h2BZQecs9YS_Xjswgs81Spf5Uz9M_uv@mail.gmail.com>
In-Reply-To: <B4268AAFAFA3E244B5B0641D5914917048BCE1C099@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8217087404679168033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 23 November 2010 16:07, Simon LETHBRIDGE
<simon.lethbridge@stericsson.com> wrote:
>> -----Original Message-----
>> From: andrzej zaborowski [mailto:balrogg(a)gmail.com]
>> Since (correct me if I'm wrong) SendPositioningControl can only be
>> called in response to PositioningRequest(), it would seem more logical
>> to skip SendPositioningControl and have the agent return the xml
>> string from PositioningRequest(), e.g.
>>
>> string PositioningRequest(string xml_element)
>>
>> A D-bus call can take a couple of minutes to respond if needed.
>>
> There may be several calls to PositioningRequest() before a response is s=
ent.
> The ofono agent would need to interpret the messages to see
> whether it should pend waiting for a response from the GNSS/GPS driver.
> Once a positioning procedure has been started it may get aborted.
> This abort may not be detected by the agent If the call
> to the PositioningRequest() does not return.

So should the agent interface additionally have a method like void
AbortPositioningRequest()?

I have posted this as just a possible idea.  However parallel agent
calls and aborting calls are both used in the agent interfaces in
bluez and ofono.  D-bus is asynchronous, so whether you call a method
and return immediately and then call another method to pass the
response, or make it a single method call is just a difference in the
protocol.

Best regards

--===============8217087404679168033==--

