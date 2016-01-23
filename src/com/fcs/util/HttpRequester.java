package com.fcs.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Map;
import java.util.Vector;

/**
 * HTTP�������?
 * @author
 */
public class HttpRequester {
	private String defaultContentEncoding;

	public HttpRequester() {
		this.defaultContentEncoding = Charset.defaultCharset().name();
	}

	/**
	 * ����GET����
	 * @param urlString
	 *            URL��ַ
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	public HttpResponser sendGet(String urlString) throws IOException {
		return this.send(urlString, "GET", null, null);
	}

	/**
	 * ����GET����
	 * @param urlString
	 *            URL��ַ
	 * @param params
	 *            �����?
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	public HttpResponser sendGet(String urlString, Map<String, String> params) throws IOException {
		return this.send(urlString, "GET", params, null);
	}

	/**
	 * ����GET����
	 * @param urlString
	 *            URL��ַ
	 * @param params
	 *            �����?
	 * @param propertys
	 *            ��������
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	public HttpResponser sendGet(String urlString, Map<String, String> params, Map<String, String> propertys) throws IOException {
		return this.send(urlString, "GET", params, propertys);
	}

	/**
	 * ����POST����
	 * @param urlString
	 *            URL��ַ
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	public HttpResponser sendPost(String urlString) throws IOException {
		return this.send(urlString, "POST", null, null);
	}

	/**
	 * ����POST����
	 * @param urlString
	 *            URL��ַ
	 * @param params
	 *            �����?
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	public HttpResponser sendPost(String urlString, Map<String, String> params) throws IOException {
		return this.send(urlString, "POST", params, null);
	}

	/**
	 * ����POST����
	 * @param urlString
	 *            URL��ַ
	 * @param params
	 *            �����?
	 * @param propertys
	 *            ��������
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	public HttpResponser sendPost(String urlString, Map<String, String> params, Map<String, String> propertys) throws IOException {
		return this.send(urlString, "POST", params, propertys);
	}

	/**
	 * ����HTTP����
	 * @param urlString
	 * @return ��ӳ����
	 * @throws IOException
	 */
	private HttpResponser send(String urlString, String method, Map<String, String> parameters, Map<String, String> propertys) throws IOException {
		HttpURLConnection urlConnection = null;

		if (method.equalsIgnoreCase("GET") && parameters != null) {
			StringBuffer param = new StringBuffer();
			int i = 0;
			for (String key : parameters.keySet()) {
				if (i == 0)
					param.append("?");
				else
					param.append("&");
				param.append(key).append("=").append(parameters.get(key));
				i++;
			}
			urlString += param;
		}
		URL url = new URL(urlString);
		urlConnection = (HttpURLConnection) url.openConnection();

		urlConnection.setRequestMethod(method);
		urlConnection.setDoOutput(true);
		urlConnection.setDoInput(true);
		urlConnection.setUseCaches(false);

		if (propertys != null)
			for (String key : propertys.keySet()) {
				urlConnection.addRequestProperty(key, propertys.get(key));
			}

		if (method.equalsIgnoreCase("POST") && parameters != null) {
			StringBuffer param = new StringBuffer();
			for (String key : parameters.keySet()) {
				param.append("&");
				param.append(key).append("=").append(parameters.get(key));
			}
			urlConnection.getOutputStream().write(param.toString().getBytes());
			urlConnection.getOutputStream().flush();
			urlConnection.getOutputStream().close();
			/*OutputStreamWriter out = new OutputStreamWriter(urlConnection.getOutputStream(), "utf-8");
			out.write(param.toString());
			//urlConnection.getOutputStream().flush();
			//urlConnection.getOutputStream().close();
			out.flush();
			out.close();*/
		}

		return this.makeContent(urlString, urlConnection);
	}

	/**
	 * �õ���Ӧ����
	 * @param urlConnection
	 * @return ��Ӧ����
	 * @throws IOException
	 */
	private HttpResponser makeContent(String urlString, HttpURLConnection urlConnection) throws IOException {
		HttpResponser HttpResponserer = new HttpResponser();
		try {
			InputStream in = urlConnection.getInputStream();
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
			HttpResponserer.contentCollection = new Vector<String>();
			StringBuffer temp = new StringBuffer();
			String line = bufferedReader.readLine();
			while (line != null) {
				HttpResponserer.contentCollection.add(line);
				temp.append(line).append("\r\n");
				line = bufferedReader.readLine();
			}
			bufferedReader.close();

			String ecod = urlConnection.getContentEncoding();
			if (ecod == null)
				ecod = this.defaultContentEncoding;

			HttpResponserer.urlString = urlString;

			HttpResponserer.defaultPort = urlConnection.getURL().getDefaultPort();
			HttpResponserer.file = urlConnection.getURL().getFile();
			HttpResponserer.host = urlConnection.getURL().getHost();
			HttpResponserer.path = urlConnection.getURL().getPath();
			HttpResponserer.port = urlConnection.getURL().getPort();
			HttpResponserer.protocol = urlConnection.getURL().getProtocol();
			HttpResponserer.query = urlConnection.getURL().getQuery();
			HttpResponserer.ref = urlConnection.getURL().getRef();
			HttpResponserer.userInfo = urlConnection.getURL().getUserInfo();

			HttpResponserer.content = new String(temp.toString().getBytes(), ecod);
			HttpResponserer.contentEncoding = ecod;
			HttpResponserer.code = urlConnection.getResponseCode();
			HttpResponserer.message = urlConnection.getResponseMessage();
			HttpResponserer.contentType = urlConnection.getContentType();
			HttpResponserer.method = urlConnection.getRequestMethod();
			HttpResponserer.connectTimeout = urlConnection.getConnectTimeout();
			HttpResponserer.readTimeout = urlConnection.getReadTimeout();

			return HttpResponserer;
		} catch (IOException e) {
			throw e;
		} finally {
			if (urlConnection != null)
				urlConnection.disconnect();
		}
	}

	/**
	 * Ĭ�ϵ���Ӧ�ַ�
	 */
	public String getDefaultContentEncoding() {
		return this.defaultContentEncoding;
	}

	/**
	 * ����Ĭ�ϵ���Ӧ�ַ�
	 */
	public void setDefaultContentEncoding(String defaultContentEncoding) {
		this.defaultContentEncoding = defaultContentEncoding;
	}

	public static void main(String[] args) throws Exception {
		HttpRequester request = new HttpRequester();
		request.setDefaultContentEncoding("utf-8");
		HttpResponser hr = request.sendGet("http://www.csdn.net");

		//System.out.println(hr.getUrlString());
		//System.out.println(hr.getProtocol());
		//System.out.println(hr.getHost());
		//System.out.println(hr.getPort());
		//System.out.println(hr.getContentEncoding());
		//System.out.println(hr.getMethod());

		//System.out.println(hr.getContent());
	}
}