Content-Type: multipart/mixed; boundary="===============8371499854591355376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 2/8] stk: Introduce BIP command handlers
Date: Wed, 08 Jun 2011 03:01:00 -0500
Message-ID: <4DEF2C3C.7090405@gmail.com>
In-Reply-To: <4DF2241F.7050108@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8371499854591355376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>>       __ofono_sms_sim_download_cb_t sms_pp_cb;
>>>       void *sms_pp_userdata;
>>> +    struct stk_channel channel;
>>> +    struct stk_channel_data rx_buffer;
>>> +    struct stk_channel_data tx_buffer;
>>
>> Are you sure you need these buffers?  At least the RX buffer can
>> probably be ignored since you can always use the kernel socket buffer
>> instead.  Copying from the kernel buffer into your own buffer just to
>> copy it into SIM's buffer seems like busywork.
>>
> =

> The idea of the Rx buffer is to introduce an intermediate buffer since
> it's up to the UICC to collect the received data with the proactive
> command 'Receive data'. But before that, we need to read the kernel
> buffer to determine the amount of data available and inform the UICC
> about this size.
> =


If this is the only reason you're introducing an rx buffer, then please
don't.  There are ioctls on tcp / udp sockets that give you this
information.  Please see FIONREAD ioctl.

> =

>> The TX buffer is arguable, you might want to use non-blocking IO, but in
>> that case I would use a ring_buffer from GAtChat.
> =

> For STK, what is the added value of a ring buffer? The mechanism for STK
> is to store data in the TX buffer and once the PDU is complete, flush it
> by sending the data. So we can't store before the Tx buffer is empty.
> =

>

Because you would have to use non-blocking IO, and your number of bytes
written to the kernel socket is not guaranteed to be the same as the
contents of the tx buffer.  So you either must memmove or use a ring
buffer which is more efficient.


>>
>> You can't actually do this since the agent does not support calling
>> stk_agent_request_cancel from within a callback.
> =

> OK, thank you for pointing this issue. But then I realize that I don't
> need to expressly release the stk session agent (through
> stk_agent_request_cancel). We just need to wait for the "End session"
> notification which is likely to be received as a result of the Terminal
> response "session terminated by user".

We've already had this discussion ;)  Please don't rely on such behavior.

Regards,
-Denis

--===============8371499854591355376==--

