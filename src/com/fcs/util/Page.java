package com.fcs.util;

/**
 * @since 2013-6-19
 */
public class Page {
    /** 为true时，将忽略翻页查�?*/
    private boolean showAll;
    /** 每页显示记录�?*/
    private int showRows = 15;
    /** 总页�?*/
    private int totalPages;
    /** 总记录数 */
    private int totalRows;
    /** 当前�?*/
    private int currentPage;
    /** 当前记录起始索引 */
    private int currentRow;

    public int getTotalPages() {
        if (totalRows % showRows == 0) {
            totalPages = totalRows / showRows;
        } else {
            totalPages = totalRows / showRows + 1;
        }
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
    }

    public int getCurrentPage() {
        if (currentPage <= 0) {
            currentPage = 1;
        }
        if (currentPage > getTotalPages() && getTotalPages() > 0) {
            currentPage = getTotalPages();
        }
        return currentPage;

    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getShowRows() {
        return showRows;
    }

    public void setShowRows(int showRows) {
        this.showRows = showRows;
    }

    public int getCurrentResult() {
        currentRow = (getCurrentPage() - 1) * getShowRows();
        if (currentRow < 0) {
            currentRow = 0;
        }
        return currentRow;
    }

    public void setCurrentRow(int currentRow) {
        this.currentRow = currentRow;
    }

    /**
     * @return the showAll
     */
    public boolean isShowAll() {
        return showAll;
    }

    /**
     * 不进行翻页，显示�?��数据
     * 
     * @param showAll the showAll to set
     */
    public void setShowAll(boolean showAll) {
        this.showAll = showAll;
    }

    /**
     * @return the currentRow
     */
    public int getCurrentRow() {
        return currentRow;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "Page [showAll=" + showAll + ", showRows=" + showRows + ", totalPages=" + totalPages + ", totalRows=" + totalRows + ", currentPage=" + currentPage + ", currentRow=" + currentRow + "]";
    }

}
