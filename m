Content-Type: multipart/mixed; boundary="===============5200928613735849711=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] coex: coex agent implementation
Date: Wed, 05 Dec 2018 14:57:00 -0600
Message-ID: <7d3e4d6d-b0b4-03ae-a7d0-21520befd72a@gmail.com>
In-Reply-To: <1543828801-31869-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5200928613735849711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 12/03/2018 03:20 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Added implementation for coex agent
> ---
>   plugins/xmm7xxx.c | 972 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 972 insertions(+)
> =


A couple of other things:

> +
> +enum coex_agent_result {
> +	COEX_AGENT_RESULT_OK,
> +	COEX_AGENT_RESULT_BACK,
> +	COEX_AGENT_RESULT_TERMINATE,
> +	COEX_AGENT_RESULT_TIMEOUT,
> +	COEX_AGENT_RESULT_BUSY,};

Some/All of these are no longer needed since you changed to noreply =

agent methods, right?

> +
> +struct bt_coex_info {
> +	int safe_tx_min;
> +	int safe_tx_max;
> +	int safe_rx_min;
> +	int safe_rx_max;
> +	int safe_vector[MAX_BT_SAFE_VECTOR];
> +	int num_safe_vector;
> +};
> +
> +struct wl_coex_info {
> +	int safe_tx_min;
> +	int safe_tx_max;
> +	int safe_rx_min;
> +	int safe_rx_max;
> +	int safe_vector[MAX_BT_SAFE_VECTOR];
> +	int num_safe_vector;
> +};
> +
> +struct coex_agent {
> +	char *path;
> +	char *bus;
> +	guint disconnect_watch;
> +	ofono_bool_t remove_on_terminate;
> +	ofono_destroy_func removed_cb;
> +	void *removed_data;
> +	DBusMessage *msg;

This is likely no longer needed...

> +	int min_length;
> +	int max_length;
> +	ofono_bool_t hidden_entry;

The above three are not needed as well?

> +};
>   =

>   struct xmm7xxx_data {
>   	GAtChat *chat;		/* AT chat */
>   	struct ofono_sim *sim;
>   	ofono_bool_t have_sim;
>   	ofono_bool_t sms_phonebook_added;
> +	unsigned int netreg_watch;
>   };
>   =

> +/* Coex Implementation */
> +enum wlan_bw {
> +	OFONO_WLAN_BW_UNSUPPORTED =3D -1,
> +	OFONO_WLAN_BW_20MHZ =3D 0,
> +	OFONO_WLAN_BW_40MHZ =3D 1,
> +	OFONO_WLAN_BW_80MHZ =3D 2,

Please don't use the OFONO_ prefix here, it is reserved for public oFono API

> +};
> +
> +struct Plmnhist {

Not really our style to use camel case structure names...

> +	unsigned short mnc;
> +	unsigned short mcc;
> +	unsigned long tdd;
> +	unsigned long fdd;
> +	unsigned char bw;
> +};
> +
> +struct ofono_coex {

Please don't use ofono_ prefix here.

> +	GAtChat *chat;
> +	struct ofono_modem *modem;
> +
> +	DBusMessage *pending;
> +	ofono_bool_t bt_active;
> +	ofono_bool_t wlan_active;
> +	enum wlan_bw wlan_bw;
> +	char *lte_band;
> +
> +	ofono_bool_t pending_bt_active;
> +	ofono_bool_t pending_wlan_active;
> +	enum wlan_bw pending_wlan_bw;
> +	ofono_bool_t lte_active;
> +
> +	struct coex_agent *session_agent;
> +};
> +

<snip>

> +
> +static void coex_default_agent_notify(gpointer user_data)
> +{
> +	struct ofono_coex *coex =3D user_data;
> +	coex_agent_free(coex->session_agent);

Should you be resetting coex->session_agent here?

> +
> +	g_at_chat_send(coex->chat, "AT+XNRTCWS=3D0", none_prefix,
> +				NULL, NULL, NULL);
> +}

Regards,
-Denis

--===============5200928613735849711==--

