Content-Type: multipart/mixed; boundary="===============8267417606635696057=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 03/18] gathdlc: add mechansim to detect '+++' escape
 sequence
Date: Thu, 31 Mar 2011 10:32:25 +0200
Message-ID: <4D943C19.3030501@linux.intel.com>
In-Reply-To: <4D939807.3020304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8267417606635696057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30/03/2011 22:52, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 03/25/2011 10:25 AM, Guillaume Zajac wrote:
>> ---
>>   gatchat/gathdlc.c |  114 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 files changed, 114 insertions(+), 0 deletions(-)
>>
>> diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
>> index 7c45454..21e4533 100644
>> --- a/gatchat/gathdlc.c
>> +++ b/gatchat/gathdlc.c
>> @@ -50,6 +50,13 @@
>>
>>   #define HDLC_FCS(fcs, c) crc_ccitt_byte(fcs, c)
>>
>> +/* Amount of fiftieths of second to detect '+++'.
>> + * Range is 0 to 0xff.
>> + */
>> +#define ESC_TIME 	0x32
> Where is this coming from?  Is this supposed to be controlled by an
> S-register?  If so, you might want to use a proper variable for this.
>> +
>> +#define GUARD_TIMEOUTS	1000	/* Pause time before and after '+++' sequen=
ce */
>> +
> This seems redundant to the ESC_TIME timeout...

GUARD_TIMEOUTS comes from S12 register (same as escape character comes =

from S2 register), however it is not implemented in GAtServer.
I don't think I can access to v250 registers from HDLC layer.

Then, I thought I needed to have minimum time e.g. ESC_TIME to detect 3 =

'+' characters and a GUARD_TIMEOUTS, that's why I used 2 variables. =

However I don't find any document speaking about ESC_TIME. So I will =

keep only GUARD_TIMEOUT.

>>   struct _GAtHDLC {
>>   	gint ref_count;
>>   	GAtIO *io;
>> @@ -68,6 +75,12 @@ struct _GAtHDLC {
>>   	gboolean in_read_handler;
>>   	gboolean destroyed;
>>   	gboolean no_carrier_detect;
>> +	GAtSuspendFunc suspend_func;
>> +	gpointer suspend_data;
>> +	guint cmpt;
>> +	guint suspend_timeout;
>> +	guint pause_timeout;
> You never clean up these g_sources (e.g. in the case where GAtHDLC is
> forcefully removed).  This is a big no no in a library, you must clean
> up after yourself in all cases.
>
> I would also replace the suspend_timeout with a GTimer directly.
>

So I will use GTimer and make sure I correctly clean it up.

>> +	gboolean paused;
>>   };
>>
>>   static void hdlc_record(int fd, gboolean in, guint8 *data, guint16 len=
gth)
>> @@ -130,6 +143,47 @@ guint32 g_at_hdlc_get_recv_accm(GAtHDLC *hdlc)
>>   	return hdlc->recv_accm;
>>   }
>>
>> +void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSuspendFunc func,
>> +							gpointer user_data)
>> +{
>> +	if (hdlc =3D=3D NULL)
>> +		return;
>> +
>> +	hdlc->suspend_func =3D func;
>> +	hdlc->suspend_data =3D user_data;
>> +}
>> +
>> +static gboolean paused_timeout_cb(gpointer user_data)
>> +{
>> +	GAtHDLC *hdlc =3D user_data;
>> +
>> +	hdlc->paused =3D TRUE;
>> +
>> +	return FALSE;
>> +}
>> +
>> +static gboolean susp_timeout_cb(gpointer user_data)
>> +{
>> +	GAtHDLC *hdlc =3D user_data;
>> +
>> +	hdlc->cmpt =3D 0;
>> +
>> +	return FALSE;
>> +}
>> +
>> +static gboolean hdlc_suspend(gpointer user_data)
>> +{
>> +	GAtHDLC *hdlc =3D user_data;
>> +
>> +	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
>> +	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
>> +
>> +	if (hdlc->suspend_func)
>> +		hdlc->suspend_func(hdlc->suspend_data);
>> +
>> +	return FALSE;
>> +}
>> +
>>   static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
>>   {
>>   	GAtHDLC *hdlc =3D user_data;
>> @@ -142,6 +196,13 @@ static void new_bytes(struct ring_buffer *rbuf, gpo=
inter user_data)
>>
>>   	hdlc->in_read_handler =3D TRUE;
>>
>> +	/*
>> +	 * We delete the the paused_timeout_cb or hdlc_suspend as soons as
>> +	 * we read a data.
>> +	 */
>> +	if (hdlc->pause_timeout>  0)
>> +		g_source_remove(hdlc->pause_timeout);
>> +
>>   	while (pos<  len) {
>>   		/*
>>   		 * We try to detect NO CARRIER conditions here.  We
>> @@ -153,6 +214,21 @@ static void new_bytes(struct ring_buffer *rbuf, gpo=
inter user_data)
>>   				hdlc->decode_offset =3D=3D 0&&  *buf =3D=3D '\r')
>>   			break;
>>
>> +		/*
>> +		 * If there was no character for 1 second we try to detect
>> +		 * the '+' character to suspend data call if 3 '+' are
>> +		 * detected in less than 20 * ESC_TIME milliseconds.
>> +		 */
>> +		if (*buf =3D=3D '+'&&  hdlc->paused) {
>> +			if (hdlc->cmpt =3D=3D 0)
>> +				hdlc->suspend_timeout =3D g_timeout_add (20 * ESC_TIME,
>> +							susp_timeout_cb, hdlc);
>> +			hdlc->cmpt++;
>> +		} else {
>> +			hdlc->cmpt =3D 0;
>> +			hdlc->paused =3D FALSE;
>> +		}
>> +
>>   		if (hdlc->decode_escape =3D=3D TRUE) {
>>   			unsigned char val =3D *buf ^ HDLC_TRANS;
>>
>> @@ -190,6 +266,9 @@ static void new_bytes(struct ring_buffer *rbuf, gpoi=
nter user_data)
>>   		}
>>   	}
>>
>> +	if (hdlc->cmpt =3D=3D 3)
>> +		goto suspend;
>> +
>>   out:
>>   	ring_buffer_drain(rbuf, pos);
>>
>> @@ -197,6 +276,37 @@ out:
>>
>>   	if (hdlc->destroyed)
>>   		g_free(hdlc);
>> +
>> +	/*
>> +	 * If there were no data pause for GUARD_TIMEOUTS ms,
>> +	 * we try again to check it.
>> +	 */
>> +	if (!hdlc->paused)
>> +		hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
>> +							paused_timeout_cb,
>> +							hdlc);
>> +
>> +	return;
>> +
>> +suspend:
>> +	/*
>> +	 * If the suspend timeout still exists,
>> +	 * delete it.
>> +	 */
>> +	if (hdlc->suspend_timeout>  0)
>> +		g_source_remove(hdlc->suspend_timeout);
>> +
>> +	/*
>> +	 * Restart the counter and reset the ring buffer.
>> +	 */
>> +	hdlc->cmpt =3D 0;
>> +	ring_buffer_reset(rbuf);
> This sounds like a really bad idea.  What are you trying to accomplish he=
re?

If I don't reset ring_buffer, I am receiving "+++" on GAtServer when I =

return to command mode and it is blocking following AT commands.
I can't send next ATH0 or ATO0. Do you have any idea how to prevent =

receiving GAtServer to receive it?

>> +
>> +	/*
>> +	 * Wait for another pause of GUARD_TIMEOUTS ms before returning to com=
mand mode.
>> +	 */
>> +	hdlc->paused =3D FALSE;
>> +	hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS, hdlc_suspend, h=
dlc);
>>   }
>>
>>   GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
>> @@ -245,6 +355,10 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
>>   	hdlc->io =3D g_at_io_ref(io);
>>   	g_at_io_set_read_handler(hdlc->io, new_bytes, hdlc);
>>
>> +	hdlc->cmpt =3D 0;
>> +
>> +	hdlc->paused =3D FALSE;
>> +
> In general it isn't necessary to initialize variables to zero since we
> use g_try_new0 which zeros the structure already.

Ok

Kind regards,
Guillaume

--===============8267417606635696057==--

